#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdint.h>
#include <mpi.h>
#include <time.h>
#include "tiff_image_vectorization.h"
#include "kd_tree.h"
#include "knn_operations.h"
#include "sorting.h"
#include "DBSCAN.h"
#include "non_border_assigning.h"
//#define k 35
#define D 15

int k = 35;

int main(int argc, char *argv[]) {

    MPI_Init(&argc, &argv); 
    int world_size, world_rank;
    MPI_Comm_size(MPI_COMM_WORLD, &world_size);
    MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);

    if (world_rank == 0){
        char *env_val = getenv("PBS_ARRAYID");
        if (!env_val) env_val = getenv("PBS_ARRAY_INDEX");
        if (env_val != NULL) {
            k = atoi(env_val);
            printf("Detected k = %d\n", k);
        } else {
            printf("Error getting k\n");
            return 1;
        }
    } 

    MPI_Bcast(&k, 1, MPI_INT, 0, MPI_COMM_WORLD);

    if (world_rank != 0){
        if(k == 35){
            printf("Not running inside a PBS array.\n");
            return 1;
        }
    }

    int width = 0;
    int height = 0;
    time_t t0 = 0;
    ImageTensor* img = NULL;


    // Tensorize image, the image is stored only in rank 0
    if (world_rank == 0) {
        t0 = time(NULL);
        //img = load_tiff_as_tensor("data/sentinel_tensor_10m.tiff", world_rank);
        img = load_tiff_as_tensor("/home/andreas.chini/my_programs/git/angle-based-clustering/data/sentinel_tensor_10m.tiff", world_rank);
        if (!img) {
            printf("ERROR: [main] Error loading TIFF\n");
            MPI_Abort(MPI_COMM_WORLD, 1);
        }

        printf("(1/11) Loaded image w=%d h=%d c=%d ", img->width, img->height, img->channels);
        fflush(stdout);
        width = img->width;
        height = img->height;   
    }

    MPI_Bcast(&width, 1, MPI_INT, 0, MPI_COMM_WORLD); // On rank 0 reads and on all other ranks it writes
    MPI_Bcast(&height, 1, MPI_INT, 0, MPI_COMM_WORLD);
    
    size_t n_points = (size_t)width * height; //size_t is like and unsigned long long int (64 bit) used to store memory values
    if (world_rank == 0) {
        time_t t1 = (long) time(NULL) - t0;
        printf("(n_points=%zu), [%02ld:%02ld]\n", n_points, (long)(int) t1/60, t1%60); //%zu is like %d but for size_t elements
        fflush(stdout);
    }

    //Allocate on ranks different from 0, then broadcast data
    float *pixel_data;
    if (world_rank == 0) {
        pixel_data = img->data;
    } else {
        pixel_data = malloc(n_points * D * sizeof(float));
    }

    MPI_Bcast(pixel_data, n_points * D, MPI_FLOAT, 0, MPI_COMM_WORLD);

    // Allocate memory for pixel pointers
    point *points = NULL;
    float *all_directions = NULL;
    points = malloc(n_points * sizeof(point)); 
    if (!points) {
        fprintf(stderr, "ERROR: [main] Error allocating pixel pointers memory\n");
        MPI_Abort(MPI_COMM_WORLD, 1);
        }
    
    // Assign the pointers the value of a pixel and also store its coordinates
    for (size_t i = 0; i < n_points; i++) {
        points[i].v = pixel_data + (i * D);
        points[i].x = i % width;
        points[i].y = i / width;
    }

    //Allocate memory for all_directions, for later use
    all_directions = malloc(n_points * D * sizeof(float));
    if (!all_directions) {
        fprintf(stderr, "ERROR: [main] Error allocating direction buffer memory\n");
        MPI_Abort(MPI_COMM_WORLD, 1);;
    }
    for (size_t i = 0; i < n_points; i++) {
        points[i].direction = all_directions + (i * D); //setting up pointers, not filling data
    }

    // Create the kd-tree for every rank
    kd_node *tree = kd_build(points, n_points, 0); 
    
    if (world_rank == 0) {
        time_t t2 = (long) time(NULL) - t0;
        printf("(2/11) Kd-tree building completed, [%02ld:%02ld]\n", (long)(int) t2/60, t2%60);
        fflush(stdout);
    }
    
    size_t split = n_points / world_size;
    size_t start = world_rank * split;
    size_t end;
    if (world_rank == world_size - 1) {
        end = n_points;
    } else {
        end = start + split;
    }

    // Add the max angle for every point
    updated_max_angles(tree, points, n_points, k, D); //Parallelization changed
    if (world_rank == 0) {
        time_t t3 = (long) time(NULL) - t0;
        printf(", [%02ld:%02ld]\n", (long)(int) t3/60, t3%60);
        fflush(stdout);
    }

    //Find the 20% barrier for border point threshold
    float p20 = _percentile(points, n_points, 20.0f); //Parallelized
    if (world_rank == 0) {
        time_t t4 = (long) time(NULL) - t0;
        printf("(4/11) Border points percentile found %f, [%02ld:%02ld]\n", p20, (long)(int) t4/60, t4%60);
        fflush(stdout);
    }
    
    //Calculate the number of border points
    size_t n_border_points = n_of_border_points(points, n_points, p20); //Parallelized
    if (n_border_points == 0) {
        fprintf(stderr, "ERROR: [main] no border points found\n");
        return 1;
    }
    
    //Copy points into border points (only actual border points), done the same for every rank
    point *border_points = malloc(n_border_points * sizeof(point));
    copy_points_and_border(points, border_points, n_points, p20, -1);
    if (!border_points) {
        fprintf(stderr, "ERROR: [main] Error allocating border_points\n");
        return 1;
    }

    // Calculate eps value for dbscan
    float eps = compute_eps(border_points, n_border_points); //Parallelized
    
    if (world_rank == 0) {
        time_t t5 = (long) time(NULL) - t0;
        printf("(5/11) Copied border points and found eps = %f, [%02ld:%02ld]\n", eps,(long)(int) t5/60, t5%60); 
        fflush(stdout);
    }

    //Compute angles for dbscan
    compute_all_directions(points, n_points, tree, k, D); //Parallelized
    if (world_rank == 0) {
        time_t t6 = (long) time(NULL) - t0;
        printf(", [%02ld:%02ld]\n", (long)(int) t6/60, t6%60); 
        fflush(stdout);
    }
    //Assign border points a label
    dbscan(border_points, n_border_points, 1.3 * eps, 8); //Not parallelized
    if (world_rank == 0) {
        time_t t7 = (long) time(NULL) - t0;
        printf("(7/11) Dbscan completed, [%02ld:%02ld]\n", (long)(int) t7/60, t7%60); 
        fflush(stdout);
    }

    //Copy the label of border points to the actual points, every rank does this
    copy_points_and_border(points, border_points, n_points, p20, 1);
    if (world_rank == 0) {
        time_t t8 = (long) time(NULL) - t0;
        printf("(8/11) Copied all labels into points[], [%02ld:%02ld]\n", (long)(int) t8/60, t8%60); 
        fflush(stdout);
    }

    // Assign non border points a label = -4, all ranks do this
    for (int i = 0; i < n_points; i++) {
        if (points[i].max_angle >= p20) {
            points[i].labelll = -4;
        }
    }

    //Create a kd-tree on the border points, a tree is needed for every rank
    kd_node *border_tree = kd_build(border_points, n_border_points, 0);
    if (world_rank == 0) {
        time_t t9 = (long) time(NULL) - t0;
        printf("(9/11) Built kd-tree for border point, [%02ld:%02ld]\n", (long)(int) t9/60, t9%60); 
        fflush(stdout);
    }

    //Assign of non border points to the nearest of border points
    non_border_points_assignment(points, border_tree, n_points); //Parallelized
    if (world_rank == 0) {
        time_t t10 = (long) time(NULL) - t0;
        printf("(10/11) Labeled all non border points, [%02ld:%02ld]\n", (long)(int) t10/60, t10%60); 
        fflush(stdout);
    }

    //Final image creation
    if (world_rank == 0) {
        int* finalImage = malloc(n_points * sizeof(int));
        if (!finalImage) {
            fprintf(stderr, "ERROR: [main] error allocating finalImage\n");
            return 1;
        }
        for (size_t i = 0; i < n_points; i++) {
            int x = points[i].x;
            int y = points[i].y;
            size_t pixel_index = (size_t)y * width + x;  // Row-major order
            finalImage[pixel_index] = points[i].labelll;
        }
        
        //Final image save
        //save_final_image("data/final_image.bin", finalImage, n_points);
        save_final_image("/home/andreas.chini/my_programs/git/angle-based-clustering/data/final_image.bin", finalImage, n_points);
        time_t t11 = (long) time(NULL) - t0;
        printf("(11/11) Exported the image in binary, [%02ld:%02ld]\n", (long)(int) t11/60, t11%60);
        fflush(stdout);
        free(finalImage);
    }
    

    // free memory
    kd_free(tree);
    kd_free(border_tree);
    free(all_directions);
    free(points);
    free(border_points);
    if (world_rank == 0){
        free(img->data);
        free(img);
    }

    MPI_Finalize();
    return 0;
}