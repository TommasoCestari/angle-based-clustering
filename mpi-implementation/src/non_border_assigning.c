#define _GNU_SOURCE
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <stdint.h>
#include <stddef.h>
#include <string.h>
#include <mpi.h>
#include "kd_tree.h"
#include "DBSCAN.h"
#include "knn_operations.h"
#include "non_border_assigning.h"

MPI_Datatype create_label_type() {
    MPI_Datatype label_type;
    int blocklengths[3] = {1, 1, 1};
    MPI_Aint displacements[3];
    // Assumes x, y, and labelll are all ints based on your snippet
    MPI_Datatype types[3] = {MPI_INT, MPI_INT, MPI_INT}; 

    displacements[0] = offsetof(label, x);
    displacements[1] = offsetof(label, y);
    displacements[2] = offsetof(label, labelll);

    MPI_Type_create_struct(3, blocklengths, displacements, types, &label_type);
    MPI_Type_commit(&label_type);
    return label_type;
}

int compare_labels(const void* a, const void* b, void* thunk) {
    const label* labelA = (const label*)a;
    const label* labelB = (const label*)b;
    
    int image_width = *(int*)thunk;

    int indexA = (labelA->y * image_width) + labelA->x;
    int indexB = (labelB->y * image_width) + labelB->x;

    if (indexA < indexB) return -1;
    if (indexA > indexB) return 1;
    return 0;
}

void non_border_points_assignment(point* points, const kd_node* border_tree, size_t n_points, 
                                    int image_width, char* img_path, double * t7_5){

    int world_size, world_rank;
    MPI_Comm_size(MPI_COMM_WORLD, &world_size);
    MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);

    int local_size, local_start;
    get_local_chunk(n_points, &local_size, &local_start);
    label* local_labels = malloc(local_size * sizeof(label));

    // Every rank calculates its part
    for (size_t i = local_start; i < (local_start + local_size); i++){
        local_labels[i-local_start].x = points[i].x;
        local_labels[i-local_start].y = points[i].y;

        if (points[i].labelll != -4) { // skip border points
            local_labels[i-local_start].labelll = points[i].labelll;
            continue; 
        } 

        knn_item nearest[1];
        kd_knn(border_tree, points[i], 1, nearest); 

        point *b = &nearest[0].point_;
        local_labels[i-local_start].labelll = b->labelll;
    }

    //Every rank sends the part that it did to every other rank
    int size[world_size], start[world_size];
    MPI_Allgather(&local_size, 1, MPI_INT, size, 1, MPI_INT, MPI_COMM_WORLD);
    MPI_Allgather(&local_start, 1, MPI_INT, start, 1, MPI_INT, MPI_COMM_WORLD);

    MPI_Datatype MPI_LABEL = create_label_type();

    label* global_labels = NULL;
    if (world_rank == 0) {
        global_labels = malloc(n_points * sizeof(label));
    }

    *t7_5 = MPI_Wtime();
    // Corrected MPI_Gatherv call
    MPI_Gatherv(local_labels, local_size, MPI_LABEL, global_labels,
                size, start, MPI_LABEL, 0, MPI_COMM_WORLD);

    if (world_rank == 0) {
        qsort_r(global_labels, n_points, sizeof(label), compare_labels, &image_width);
        FILE* f = fopen(img_path, "wb");
        if (f == NULL) {
            fprintf(stderr, "ERROR: Could not open file %s for writing\n", img_path);
        } else {
            for (size_t i = 0; i < n_points; i++) {
                fwrite(&(global_labels[i].labelll), sizeof(int), 1, f);
            }
            fclose(f);
        }
        free(global_labels);
    }
    free(local_labels);
    MPI_Type_free(&MPI_LABEL);
}

void non_border_points_assignment_2(point* points, const kd_node* border_tree, size_t n_points, label* local_labels){

    int world_size, world_rank;
    MPI_Comm_size(MPI_COMM_WORLD, &world_size);
    MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);

    int local_size, local_start;
    get_local_chunk(n_points, &local_size, &local_start);

    // Every rank calculates its part
    for (size_t i = local_start; i < (local_start + local_size); i++){
        local_labels[i-local_start].x = points[i].x;
        local_labels[i-local_start].y = points[i].y;

        if (points[i].labelll != -4) { // skip border points
            local_labels[i-local_start].labelll = points[i].labelll;
            continue; 
        } 

        knn_item nearest[1];
        kd_knn(border_tree, points[i], 1, nearest); 

        point *b = &nearest[0].point_;
        local_labels[i-local_start].labelll = b->labelll;
    }
}


void get_local_chunk(long int n_points, int* local_size, 
                     int* local_start) {
    int world_size, world_rank;
    MPI_Comm_size(MPI_COMM_WORLD, &world_size);
    MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);

    int base_size = n_points / world_size;
    int remainder = n_points % world_size;

    // 1. Calculate local size
    if (world_rank < remainder) {
        *local_size = base_size + 1;
    } else {
        *local_size = base_size;
    }

    // 2. Calculate local start
    if (world_rank < remainder) {
        *local_start = world_rank * (*local_size);
    } else {
        *local_start = world_rank * base_size + remainder;
    }
}


void data_transfer(int world_size, int world_rank, int image_width, int image_height, 
                    int n_total_points, int* local_size, label** local_labels){

    MPI_Datatype MPI_LABEL = create_label_type();
    int old_local_size = *local_size;
    label* old_local_labels = *local_labels;

    // 1. Calculate target ranges based on total flat pixels
    int TOTAL_POINTS = image_height * image_width; // e.g., 3 * 3 = 9
    int range_per_rank = (TOTAL_POINTS + world_size - 1) / world_size; // Points per node

    // 2. Count how many elements go to each rank using flat index
    int* send_counts = (int*)calloc(world_size, sizeof(int));
    for (int i = 0; i < old_local_size; i++) {
        // Convert 2D coordinates back to the global 1D position
        int global_idx = (old_local_labels[i].y * image_width) + old_local_labels[i].x;

        int target_rank = global_idx / range_per_rank; 
        if (target_rank >= world_size) target_rank = world_size - 1; 

        send_counts[target_rank]++;
    }

    // 3. Calculate send displacements (Prefix Sum)
    int* send_displs = (int*)malloc(world_size * sizeof(int));
    send_displs[0] = 0;
    for (int i = 1; i < world_size; i++) {
        send_displs[i] = send_displs[i - 1] + send_counts[i - 1];
    }

    // 4. Pack data into the flat send buffer
    label* send_buf = (label*)malloc(old_local_size * sizeof(label));
    int* current_idx = (int*)malloc(world_size * sizeof(int));
    memcpy(current_idx, send_displs, world_size * sizeof(int));

    // 4. Pack data into the flat send buffer using flat index
    for (int i = 0; i < old_local_size; i++) {
        int global_idx = (old_local_labels[i].y * image_width) + old_local_labels[i].x;

        int target_rank = global_idx / range_per_rank;
        if (target_rank >= world_size) target_rank = world_size - 1;

        send_buf[current_idx[target_rank]++] = old_local_labels[i];
    }

    // 5. Share counts so everyone knows what they are receiving
    int* recv_counts = (int*)malloc(world_size * sizeof(int));
    MPI_Alltoall(send_counts, 1, MPI_INT, recv_counts, 1, MPI_INT, MPI_COMM_WORLD);

    // 6. Calculate receive displacements and allocate final buffer
    int* recv_displs = (int*)malloc(world_size * sizeof(int));
    recv_displs[0] = 0;
    for (int i = 1; i < world_size; i++) {
        recv_displs[i] = recv_displs[i - 1] + recv_counts[i - 1];
    }
    int total_recv_size = recv_displs[world_size - 1] + recv_counts[world_size - 1];
    label* recv_buf = (label*)malloc(total_recv_size * sizeof(label));

    // 7. The Global Shuffle
    MPI_Alltoallv(send_buf, send_counts, send_displs, MPI_LABEL,
                  recv_buf, recv_counts, recv_displs, MPI_LABEL, MPI_COMM_WORLD);

    free(old_local_labels);
    *local_labels = recv_buf;
    *local_size = total_recv_size;

    // Free memory
    free(send_counts); free(send_displs); free(recv_counts); free(recv_displs);
    free(send_buf); free(current_idx);
    MPI_Type_free(&MPI_LABEL);

    
}

void reorder_and_print(int image_width, label* local_labels, int local_num_elements, 
                       char* img_path) {
    
    // 1. Local Sort using qsort_r
    qsort_r(local_labels, local_num_elements, sizeof(label), compare_labels, &image_width);

    // 2. Open the file collectively
    MPI_File fh;
    int ierr = MPI_File_open(MPI_COMM_WORLD, img_path, 
                              MPI_MODE_CREATE | MPI_MODE_WRONLY, 
                              MPI_INFO_NULL, &fh);
    if (ierr != MPI_SUCCESS) {
        printf("ERROR: Failed to open MPI File\n");
        MPI_Abort(MPI_COMM_WORLD, 1);
    }

    // 3. Create a custom MPI datatype to extract ONLY the 'labelll' integer from the struct
    int blocklengths[1] = {1};                       
    MPI_Aint displacements[1];                       
    displacements[0] = offsetof(label, labelll);     // Find exact byte offset of 'labelll'
    MPI_Datatype types[1] = {MPI_INT};               // It is a 4-byte integer

    MPI_Datatype label_int_type;
    // Create the base type targeting just that integer inside the structure
    MPI_Type_create_struct(1, blocklengths, displacements, types, &label_int_type);

    // Resize it so MPI knows the next element is 'sizeof(label)' bytes away
    MPI_Datatype local_file_type;
    MPI_Type_create_resized(label_int_type, 0, sizeof(label), &local_file_type);
    MPI_Type_commit(&local_file_type);

    // 4. Calculate where this node starts writing in the global file
    // We find the global 1D index of the very first element this node holds
    MPI_Offset global_offset = 0;
    if (local_num_elements > 0) {
        global_offset = (MPI_Offset)((local_labels[0].y * image_width) + local_labels[0].x) * sizeof(int);
    }

    // 5. Set the file view and write collectively
    // Each rank sees the file starting at its own global_offset, writing raw integers
    MPI_File_set_view(fh, global_offset, MPI_INT, MPI_INT, "native", MPI_INFO_NULL);
    
    // Write using our custom datatype that pulls 'labelll' directly out of the struct array
    MPI_File_write_all(fh, local_labels, local_num_elements, local_file_type, MPI_STATUS_IGNORE);

    // Free memory
    MPI_Type_free(&local_file_type);
    MPI_Type_free(&label_int_type);
    MPI_File_close(&fh);
}
