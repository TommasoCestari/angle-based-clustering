#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdint.h>
#include <time.h>
#include "tiff_image_vectorization.h"
#include "kd_tree.h"
#include "knn_operations.h"
#include "sorting.h"
#include "DBSCAN.h"
//#define k 35
#define D 15

int k = 35;

int main(int argc, char *argv[]) {

    //char *env_val = getenv("PBS_ARRAY_INDEX");
    //
    //if (env_val != NULL) {
    //    k = atoi(env_val);
    //    printf("Detected k = %d\n", k);
    //} else {
    //    printf("Not running inside a PBS array.\n");
    //    return 1;
    //}

    time_t t0 = time(NULL);
    // Tensorize image
    // ImageTensor* img = load_tiff_as_tensor("data/sentinel_tensor_original_small.tiff");
    ImageTensor* img = load_tiff_as_tensor("/home/andreas.chini/my_programs/git/angle-based-clustering/data/sentinel_tensor_10m.tiff");
    if (!img) {
        printf("Error loading TIFF\n");
        return 1;
    }
    time_t t1 = (long) time(NULL) - t0;
    printf("(1/11) Loaded image w=%d h=%d c=%d", img->width, img->height, img->channels);
    fflush(stdout);
    int width = img->width; int height = img->height;

    // Allocate memory for pixel pointers
    size_t n_points = (size_t)img->width * img->height; //size_t is like and unsigned long long int (64 bit) used to store memory values
    printf(" (n_points=%zu), [%02ld:%02ld]\n", n_points, (long)(int) t1/60, t1%60); //%zu is like %d but for size_t elements
    fflush(stdout);

    point *points = malloc(n_points * sizeof(point)); 
    if (!points) {
        printf("Error allocating pixel pointers memory");
        return 1;
    }

    // Assign the pointers the value of a pixel and also store its coordinates
    for (size_t i = 0; i < n_points; i++) {
        points[i].v = img->data + (i * img->channels);
        points[i].x = i % img->width;   // column
        points[i].y = i / img->width;   // row
    }

    /* allocate one contiguous block for all direction vectors for performance */
    float *all_directions = malloc(n_points * D * sizeof(float)); //same size as img -> data, but instead of raw pixel values has normalized angular vectors 
    if (!all_directions) {
        fprintf(stderr, "Error allocating direction buffer\n");
        return 1;
    }
    for (size_t i = 0; i < n_points; i++) {
        points[i].direction = all_directions + (i * D); //setting up pointers, not filling data
    }

    // Create the kd-tree
    kd_node *tree = kd_build(points, n_points, 0);
    time_t t2 = (long) time(NULL) - t0;
    printf("(2/11) Kd-tree building completed, [%02ld:%02ld]\n", (long)(int) t2/60, t2%60);
    fflush(stdout);
    
    // Add the max angle for every point
    updated_max_angles(tree, points, n_points, k, D); // (3/10)
    time_t t3 = (long) time(NULL) - t0;
    printf(", [%02ld:%02ld]\n", (long)(int) t3/60, t3%60);

    //Find the 30% barrier for border point threshold
    float p20 = _percentile(points, n_points, 20.0f);
    time_t t4 = (long) time(NULL) - t0;
    printf("(4/11) Border points percentile found, [%02ld:%02ld]\n", (long)(int) t4/60, t4%60);
    fflush(stdout);
    
    size_t n_border_points = n_of_border_points(points, n_points, p20);
    if (n_border_points == 0) {
        fprintf(stderr, "ERROR: no border points found\n");
        return 1;
    }
    point *border_points = malloc(n_border_points * sizeof(point));

    //Compute angles for dbscan
    compute_all_directions(points, n_points, tree, k, D);
    time_t t5 = (long) time(NULL) - t0;
    printf(", [%02ld:%02ld]\n", (long)(int) t5/60, t5%60);

    //Copy points into border points (only actual border points)
    copy_points_and_border(points, border_points, n_points, p20, -1);
    if (!border_points) {
    fprintf(stderr, "Error allocating border_points\n");
    return 1;
    }

    // Calculate eps value for dbscan
    float eps = compute_eps(border_points, n_border_points);
    time_t t6 = (long) time(NULL) - t0;
    printf("(6/11) Copied border points and found eps, [%02ld:%02ld]\n", (long)(int) t6/60, t6%60);

    //Assign border points a label
    dbscan(border_points, n_border_points, 4.5f * eps, 8);
    time_t t7 = (long) time(NULL) - t0;
    printf("(7/11) Dbscan completed, [%02ld:%02ld]\n", (long)(int) t7/60, t7%60);
    fflush(stdout);

    //Copy the label of border points to the actual points
    copy_points_and_border(points, border_points, n_points, p20, 1);
    time_t t8 = (long) time(NULL) - t0;
    printf("(8/11) Copied all labels into points[], [%02ld:%02ld]\n", (long)(int) t8/60, t8%60);
    fflush(stdout);

    // Assign non border points a label = -4
    for (int i = 0; i < n_points; i++) {
        if (points[i].max_angle >= p20) {
            points[i].labelll = -4;
        }
    }

    //Assigning of non border points
    //Create a kd-tree on the border points
    kd_node *border_tree = kd_build(border_points, n_border_points, 0);
    time_t t9 = (long) time(NULL) - t0;
    printf("(9/11) Built kd-tree for border points, [%02ld:%02ld]\n", (long)(int) t9/60, t9%60);
    fflush(stdout);

    for (int i = (n_points-1); i > -1; i--) {

        if (points[i].labelll != -4) {continue;}   // skip border points

        knn_item nearest[1];
        kd_knn(border_tree, points[i], 1, nearest); //Find the point nearest to the point in the kd_tree

        point *b = &nearest[0].point_;

        points[i].labelll = b->labelll;
    }
    time_t t10 = (long) time(NULL) - t0;
    printf("(10/11) Labeled all non border points, [%02ld:%02ld]\n", (long)(int) t10/60, t10%60);
    fflush(stdout);

    //Final image creation
    int* finalImage = malloc(n_points * sizeof(int));
    if (!finalImage) {
        fprintf(stderr, "Error allocating finalImage\n");
        return 1;
    }
    // Write each label to its correct spatial position
    for (size_t i = 0; i < n_points; i++) {
        int x = points[i].x;
        int y = points[i].y;
        size_t pixel_index = (size_t)y * width + x;  // Row-major order
        finalImage[pixel_index] = points[i].labelll;
    }

    //Final image save
    //save_final_image("data/final_image.bin", finalImage, n_points);
    save_final_image("/home/andreas.chini/my_programs/git/angle-based-clustering/data/sentinel_tensor_10m.tiff", finalImage, n_points);
    time_t t11 = (long) time(NULL) - t0;
    printf("(11/11) Exported the image in binary, [%02ld:%02ld]\n", (long)(int) t11/60, t11%60);
    fflush(stdout);

    // free memory
    kd_free(tree);
    kd_free(border_tree);
    free(all_directions);
    free(points);
    free(border_points);
    free(img->data);
    free(img);
    free(finalImage);

    return 0;
}
