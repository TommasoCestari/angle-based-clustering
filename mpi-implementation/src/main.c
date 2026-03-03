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
#include "log_results.h"
#define D 15

int k = 35;

int main(int argc, char *argv[]) {

    MPI_Init(&argc, &argv);
    int world_size, world_rank;
    MPI_Comm_size(MPI_COMM_WORLD, &world_size);
    MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);

    // If we dont get all necessary parameter abort the program
    if (argc < 6) {
        if (world_rank == 0) printf("Usage: %s <k> <mult_eps> <min_pts> <csv_path>\n", argv[0]);
        MPI_Finalize(); 
        return 1;
    }

    // Get values directly from the pbs job, these impact the final result and number of clusters found
    k = atoi(argv[1]); //Assign the k number of nearest neighbors search, 5 - 40 suggested
    float mult_eps = (float)atof(argv[2]); //Assign the eps multiplier, 1.0 - 1.3 suggested
    int min_pts = atoi(argv[3]); //Assign the minimum points for the kd_tree, 4 - 8 suggested
    
    // Get info from cpu used to keep the results constant
    // Standard is Intel(R) Xeon(R) Gold 6252N (100%), fast is Intel(R) Xeon(R) Gold 6418H (~150%), slow is Intel(R) Xeon(R) Gold 5118 CPU (~80%)
    char* cpu_info = argv[4]; 
    char* csv_path = argv[5];

    int width = 0;
    int height = 0;
    double t0=0, t1=0, t2=0, t2_5=0, t2_6=0, t3=0, t4=0, t5=0, t6=0, t7=0, t8=0, t9=0, t10=0, t11=0;
    ImageTensor* img = NULL;

    // Tensorize image, the image is stored only in rank 0
    if (world_rank == 0) {
        t0 = MPI_Wtime();
        img = load_tiff_as_tensor("/home/andreas.chini/my_programs/git/angle-based-clustering/data/sentinel_tensor_10m.tiff", world_rank);
        //img = load_tiff_as_tensor("data/sentinel_tensor_original_small.tiff", world_rank);
        if (!img) {
            printf("ERROR: [main] Error loading TIFF\n");
            MPI_Abort(MPI_COMM_WORLD, 1);
        }

        printf("(1/11) Loaded image w=%d h=%d c=%d ", img->width, img->height, img->channels);
        fflush(stdout);
        width = img->width;
        height = img->height;   
    }

    // Send image dimentions to all ranks, Rank 0 reads and sends, all other ranks write
    MPI_Bcast(&width, 1, MPI_INT, 0, MPI_COMM_WORLD);
    MPI_Bcast(&height, 1, MPI_INT, 0, MPI_COMM_WORLD);
    
    size_t n_points = (size_t)width * height; //size_t is like and unsigned long long int (64 bit) used to store memory values
    if (world_rank == 0) {
        t1 = MPI_Wtime() - t0;
        printf("(n_points=%zu), [%02d:%05.2f]\n", n_points, (int)(t1/60), fmod(t1, 60.0));
        fflush(stdout);
    }

    //Allocate on ranks different from 0, then broadcast data
    float *pixel_data;
    if (world_rank == 0) {
        pixel_data = img->data;
    } else {
        pixel_data = malloc(n_points * D * sizeof(float));
    }

    // Send the pixel data to ranks != 0 
    MPI_Bcast(pixel_data, n_points * D, MPI_FLOAT, 0, MPI_COMM_WORLD);

    // Every rank allocates memory for pixel pointers
    point *points = NULL;
    points = malloc(n_points * sizeof(point)); 
    if (!points) {
        printf("ERROR: [main] Error allocating pixel pointers memory\n"); fflush(stdout);
        MPI_Abort(MPI_COMM_WORLD, 1);
        }
    
    // Assign the pointers the value of a pixel and also store its coordinates
    for (size_t i = 0; i < n_points; i++) {
        points[i].v = pixel_data + (i * D);
        points[i].x = i % width;
        points[i].y = i / width;
    }

    //Allocate memory for all_directions, for later use
    float *all_directions = malloc(n_points * D * sizeof(float));
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
        t2 = MPI_Wtime() - t0;
        printf("(2/11) Kd-tree building completed, [%02d:%05.2f]\n", (int) t2/60, fmod(t2, 60.0));
        fflush(stdout);
    }
    
    // Add the max angle for every point
    updated_max_angles(tree, points, n_points, k, D, &t2_5, &t2_6);
    if (world_rank == 0) {
        t2_5 = t2_5 - t0;
        t2_6 = t2_6 - t0;
        t3 = MPI_Wtime() - t0;
        printf(", [%02d:%05.2f]\n", (int)(t3/60), fmod(t3, 60.0));
        fflush(stdout);
    }

    //Find the 20% barrier for border point threshold
    float p20 = _percentile(points, n_points, 20.0f); //Parallelized
    if (world_rank == 0) {
        t4 = MPI_Wtime() - t0;
        printf("(4/11) Border points percentile found %f, [%02d:%05.2f]\n", p20, (int)(t4/60), fmod(t4, 60.0));
        fflush(stdout);
    }
    
    //Calculate the number of border points
    size_t n_border_points = n_of_border_points(points, n_points, p20); //Parallelized
    if (n_border_points == 0) {
        printf("ERROR: [main] no border points found\n"); fflush(stdout);
        MPI_Abort(MPI_COMM_WORLD, 1);
    }
    
    //Copy points into border points (only actual border points), done the same for every rank
    point *border_points = malloc(n_border_points * sizeof(point));
    copy_points_and_border(points, border_points, n_points, p20, -1);
    if (!border_points) {
        printf("ERROR: [main] Error allocating border_points\n"); fflush(stdout);
        MPI_Abort(MPI_COMM_WORLD, 1);
    }

    // Calculate eps value for dbscan
    float eps = compute_eps(border_points, n_border_points); //Parallelized
    
    if (world_rank == 0) {
        t5 = MPI_Wtime() - t0;
        printf("(5/11) Copied border points and found eps, [%02d:%05.2f]\n", (int)(t5/60), fmod(t5, 60.0)); 
        fflush(stdout);
    }

    //Compute angles for dbscan
    compute_all_directions(points, n_points, tree, k, D); //Parallelized
    if (world_rank == 0) {
        t6 = MPI_Wtime() - t0;
        printf(", [%02d:%05.2f]\n", (int)(t6/60), fmod(t6, 60.0)); 
        fflush(stdout);
    }
    
    //Assigns border points a label and returns the number of clusters found
    int num_clusters = dbscan(border_points, n_border_points, mult_eps * eps, min_pts); //Not parallelized
    if (world_rank == 0) {
        t7 = MPI_Wtime() - t0;
        printf("(7/11) Dbscan completed, [%02d:%05.2f]\n", (int)(t7/60), fmod(t7, 60.0));
        fflush(stdout);
    }

    //Copy the label of border points to the actual points, every rank does this
    copy_points_and_border(points, border_points, n_points, p20, 1);
    if (world_rank == 0) {
        t8 = MPI_Wtime() - t0;
        printf("(8/11) Copied all labels into points[], [%02d:%05.2f]\n", (int)(t8/60), fmod(t8, 60.0)); 
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
        t9 = MPI_Wtime() - t0;
        printf("(9/11) Built kd-tree for border point, [%02d:%05.2f]\n", (int)(t9/60), fmod(t9, 60.0));   
        fflush(stdout);
    }

    //Assign of non border points to the nearest of border points
    non_border_points_assignment(points, border_tree, n_points); //Parallelized
    if (world_rank == 0) {
        t10 = MPI_Wtime() - t0;
        printf("(10/11) Labeled all non border points, [%02d:%05.2f]\n", (int)(t10/60), fmod(t10, 60.0));; 
        fflush(stdout);
    }

    // Final image creation, only done 1 time with rank 0
    if (world_rank == 0) {
        int* finalImage = malloc(n_points * sizeof(int));
        if (!finalImage) {
            printf("ERROR: [main] error allocating finalImage\n"); fflush(stdout);
            MPI_Abort(MPI_COMM_WORLD, 1);
        }
        for (size_t i = 0; i < n_points; i++) {
            int x = points[i].x;
            int y = points[i].y;
            size_t pixel_index = (size_t)y * width + x;  // Row-major order
            finalImage[pixel_index] = points[i].labelll;
        }
        
        //Final image save
        char img_path[256];
        //sprintf(img_path, "data/img_k%d_e%.1f_m%d.bin", k, mult_eps, min_pts);
        sprintf(img_path, "/home/andreas.chini/my_programs/git/angle-based-clustering/data/img_k%d_e%.1f_m%d.bin", k, mult_eps, min_pts);
        save_final_image(img_path, finalImage, n_points);
        t11 = MPI_Wtime() - t0;
        printf("(11/11) Exported the image in binary, [%02d:%05.2f]\n", (int)(t11/60), fmod(t11, 60.0));
        fflush(stdout);

        log_results(csv_path, (int)n_points, k, mult_eps, min_pts, world_size,
                    t1, t2, t2_5, t2_6, t3, t4, t5, t6, t7, t8, t9, t10, t11, num_clusters, cpu_info);
        printf("Results saved to %s\n", csv_path);

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

