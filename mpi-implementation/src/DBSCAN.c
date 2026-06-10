#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <stdint.h>
#include <mpi.h>
#include "kd_tree.h"
#include "DBSCAN.h"
#include "knn_operations.h"
#include "non_border_assigning.h"

#define UNVISITED -1
#define NOISE     -2
#define D 15


/* If a = -1 copies every point that satisfies max_angle < p20 from points into border_points
*  If a = 1 for those points with max_angle < p20 copied the label form border_points into points.labelll
*/
void copy_points_and_border (point* points, point* border_points, int n_points, float p20, int a){
    if(a == 1){
        int b = 0;
        for (int i = 0; i < n_points; i++) {
            if (points[i].max_angle < p20) {
                points[i].labelll = border_points[b++].labelll;
            }
        }
    } else if (a == -1){
        int b = 0;
        for (int i = 0; i < n_points; i++) {
            if (points[i].max_angle < p20) {
                border_points[b++] = points[i];
            }
        }
    } else {printf("ERROR: [copy_points_and_border] wrong parameter, copy operation failed");}
}


float compute_eps(const point* border_points, size_t n_border)
{
    //Find the starting point(start[]) and the number of iterations(size[]) for every process
    int local_size, local_start;
    get_local_chunk(n_border, &local_size, &local_start);


    //Every rank does it's part of the sum
    float sum = 0.0f;
    for (size_t i = local_start; i < (local_start + local_size); i++){
        sum += border_points[i].mean_knn_dist;
    }

    //Allreduce sums the result of each process all toghether and gives the total sum back to everyone
    MPI_Allreduce(MPI_IN_PLACE, &sum, 1, MPI_FLOAT, MPI_SUM, MPI_COMM_WORLD);
    
    return (float) (sum / n_border);
}


static float euclidean_distance(const point *a, const point *b, int dims)
{
    float d = 0.0f;
    for (int i = 0; i < dims; i++) {
        float diff = a->v[i] - b->v[i];
        d += diff * diff;
    }
    return sqrtf(d);
}


int range_query(point *points, int n_points, int idx, float eps, int *neighbors)
{
    int count = 0;
    for (int i = 0; i < n_points; i++) {
        if (i == idx) continue;

        float d = modified_distance(&points[idx], &points[i], 0.3, D); //tra 0.2 e 1
        if (d <= eps) {
            neighbors[count++] = i;
        }
    }
    return count;
}


static void expand_cluster(point *points, int n_points, int idx, 
                            int cluster_id, float eps, int minPts)
{
    int *neighbors = malloc(n_points * sizeof(int));
    int *queue     = malloc(n_points * sizeof(int));
    int queue_capacity = n_points;

    int n_neighbors = range_query(points, n_points, idx, eps, neighbors);

    points[idx].labelll = cluster_id;

    int q_start = 0;
    int q_end   = 0;

    for (int i = 0; i < n_neighbors; i++) {
        if (q_end >= n_points) {
            fprintf(stderr, "WARNING: Queue overflow in expand_cluster! Cluster may be incomplete.\n");
            break;
        }
        queue[q_end++] = neighbors[i];
    }

    while (q_start < q_end) {
    int q = queue[q_start++];
    
    // Convert noise points to cluster members
    if (points[q].labelll == NOISE) {
        points[q].labelll = cluster_id;
    }
    
    // Skip already-processed points (shouldn't happen with -3 marker)
    if (points[q].labelll != UNVISITED && points[q].labelll != -3) {
        continue;
    }
    
    // Assign cluster label
    points[q].labelll = cluster_id;
    
    // Find neighbors
    int n_q_neighbors = range_query(points, n_points, q, eps, neighbors);
    
    if (n_q_neighbors >= minPts) {
        for (int i = 0; i < n_q_neighbors; i++) {
            int n = neighbors[i];
            // Only queue unvisited points
            if (points[n].labelll == UNVISITED) {
                // ✅ Reallocate if needed
                if (q_end >= queue_capacity) {
                    queue_capacity *= 2;
                    queue = realloc(queue, queue_capacity * sizeof(int));
                    if (!queue) {
                        fprintf(stderr, "ERROR: Failed to reallocate queue\n");
                        free(neighbors);
                        return;
                    }
                }
                points[n].labelll = -3;
                queue[q_end++] = n;
            }
        }
    }
}

    free(neighbors);
    free(queue);
}


int dbscan(point *points, int n_points, float eps, int minPts)
{
    int world_rank; 
    MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);

    if(world_rank == 0) ("Dbscan start: n_points=%d, eps=%f, minPts=%d\n", n_points, eps, minPts);

    /* initialize labels */
    for (int i = 0; i < n_points; i++) {
        points[i].labelll = UNVISITED;
    }

    int cluster_id = 0;
    size_t progress_interval = (n_points >= 100) ? n_points/100 : 1;

    for (int i = 0; i < n_points; i++) {
        
        //Structure for printing the progress
        //if (i % progress_interval == 0 || i == n_points - 1) {
        //    float percent = (float)(i + 1) / n_points * 100.0f;
        //    printf("\rDbscan progress: %.1f%% (%d/%d)", percent, i + 1, n_points);
        //    fflush(stdout);
        //}

        if (points[i].labelll != UNVISITED)
            continue;

        int *neighbors = malloc(n_points * sizeof(int));
        int n_neighbors = range_query(points, n_points, i, eps, neighbors);

        if (n_neighbors < minPts) {
            points[i].labelll = NOISE;
            free(neighbors);
            continue;
        }

        expand_cluster(points, n_points,
                       i, cluster_id, eps, minPts);

        //printf("\ndbscan: finished cluster %d\n", cluster_id);
        //fflush(stdout);

        cluster_id++;
        free(neighbors);
    }

    if(world_rank == 0) printf("dbscan done: found %d clusters\n", cluster_id);
    return cluster_id;
}


//Save image labels data on external file
void save_final_image(const char* filename, int* finalImage, size_t n_points) {
    FILE* f = fopen(filename, "wb");
    if (!f) {
        perror("Cannot open file to save finalImage");
        return;
    }

    uint16_t* buffer = malloc(n_points * sizeof(uint16_t));
    if (!buffer) {
        perror("Memory allocation failed");
        fclose(f);
        return;
    }

    for (size_t i = 0; i < n_points; i++) {
        buffer[i] = (finalImage[i] < 0) ? 0 : (uint16_t)(finalImage[i] + 1);
    }

    fwrite(buffer, sizeof(uint16_t), n_points, f);

    free(buffer);
    fclose(f);
}

//Modified distance for DBSCAN
void compute_point_direction(point* query_point, const kd_node* tree, int k, int dims)
{
    // --- 1. Find kNN ---
    knn_item neighbors[k];
    kd_knn(tree, *query_point, k, neighbors);

    // --- 2. Compute mean direction vector = mean(neighbor - query) ---
    for (int d = 0; d < dims; d++) {
        query_point->direction[d] = 0.0f;
    }

    for (int i = 0; i < k; i++) {
        for (int d = 0; d < dims; d++) {
            query_point->direction[d] +=
                neighbors[i].point_.v[d] - query_point->v[d];
        }
    }

    for (int d = 0; d < dims; d++) {
        query_point->direction[d] /= k;
    }
}


void compute_all_directions(point* points, int n_points,
                            const kd_node* tree, int k, int dims, double* t4_5)
{
    int world_size, world_rank;
    MPI_Comm_size(MPI_COMM_WORLD, &world_size);
    MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);

    int local_size, local_start;
    get_local_chunk(n_points, &local_size, &local_start);

    //Find the starting point(start[]) and the number of iterations(size[]) for every process
    int size[world_size], start[world_size];
    MPI_Allgather(&local_size, 1, MPI_INT, size, 1, MPI_INT, MPI_COMM_WORLD);
    MPI_Allgather(&local_start, 1, MPI_INT, start, 1, MPI_INT, MPI_COMM_WORLD);

    //Every rank calculaters it's part 
    float *direction = malloc(n_points * dims * sizeof(float));
        if (!direction) {
        fprintf(stderr, "ERROR: malloc direction failed\n");
        MPI_Abort(MPI_COMM_WORLD, 1);
    }

    //size_t progress_interval = (n_points >= 100) ? n_points/100 : 1;

    for (size_t i = local_start; i < (local_start + local_size); i++){
        
        //Printing of progress
        //if(world_rank == 0){
        //    if ((i % progress_interval) == 0 || i == n_points - 1) {
        //        float percent = (float)(i + 1) / n_points * 100.0f;
        //        printf("\rCompute_all_directions: %.1f%% (%d/%d)", percent, i, n_points);
        //        fflush(stdout); // Force the output to show immediately
        //    }
        //}

        //Computing of the direction
        compute_point_direction(&points[i], tree, k, dims);
        for(int d = 0; d < dims; d++) direction[i * dims + d] = points[i].direction[d];
        
    }

    *t4_5 = MPI_Wtime();

    int recvcounts[world_size], displacement[world_size];

    for (int p = 0; p < world_size; p++) {
        recvcounts[p] = size[p] * dims;
        displacement[p] = start[p] * dims;
    }

    //Every rank sends the part that it did to every other rank
    MPI_Allgatherv(&direction[local_start * dims], /* sendbuf */
           local_size * dims,              /* sendcount (floats) */
           MPI_FLOAT, direction,                           /* recvbuf (flat, all data) */
           recvcounts, displacement,
           MPI_FLOAT, MPI_COMM_WORLD);
           
    //Now that the max_angles[] vector contains all the data every rank copies it to itself
    for (size_t i = 0; i < n_points; i++){
        for (size_t d = 0; d < dims; d++){
            points[i].direction[d] = direction[i * dims + d];
        }
    }
    free(direction);
    if(world_rank == 0) printf("(6/10) Compute_all_directions: 100%% (%d/%d)", n_points, n_points);
}


float modified_distance(const point *a, const point *b, float sigma_mod, int dims)
{
    // --- 1. Euclidean distance between points (feature space) ---
    float d_eucl = euclidean_distance(a, b, dims);

    // --- 2. Cosine of angle between direction vectors ---
    float mag_a = vector_magnitude(a->direction, dims);
    float mag_b = vector_magnitude(b->direction, dims);

    float cos_theta = 0.0f;

    if (mag_a > 1e-8f && mag_b > 1e-8f) {
        cos_theta = vector_dot_product(a->direction, b->direction, dims)
                    / (mag_a * mag_b);

        // numerical safety
        if (cos_theta >  1.0f) cos_theta =  1.0f;
        if (cos_theta < -1.0f) cos_theta = -1.0f;
    }

    // --- 3. Direction-angle modifier (Eq. 2) ---
    float factor = 1.0f + ((sigma_mod - 1.0f) / 3.1415) * cos_theta;

    // --- 4. Final modified distance ---
    return d_eucl * factor;
}
