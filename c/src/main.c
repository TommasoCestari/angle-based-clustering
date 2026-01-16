#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdint.h>
#include "tiff_image_vectorization.h"
#include "kd_tree.h"
#include "knn_operations.h"
#include "sorting.h"
#include "DBSCAN.h"
#define k 5



int main(int argc, char *argv[]) {
    // Tensorize image
    ImageTensor* img = load_tiff_as_tensor("data/sentinel_tensor_10m.tiff");
    if (!img) {
        printf("Error loading TIFF\n");
        return 1;
    }
    printf("main: loaded image w=%d h=%d c=%d\n", img->width, img->height, img->channels);
    fflush(stdout);
    int width = img->width; int height = img->height; int D = img->channels;

    // Allocate memory for pixel pointers
    size_t n_points = (size_t)img->width * img->height;
    printf("main: n_points=%zu\n", n_points);
    fflush(stdout);
    point *points = malloc(n_points * sizeof(point)); 
    if (!points) {
        printf("Error allocating pixel pointers memory");
        return 1;
    }

    // Assign the pointers the value of a pixel and also store it's coordinates
    for (size_t i = 0; i < n_points; i++) {
        points[i].v = img->data + (i * img->channels);
        points[i].x = i % img->width;   // column
        points[i].y = i / img->width;   // row
    }
    
    /* allocate one contiguous block for all direction vectors for performance */
    float *all_directions = malloc(n_points * D * sizeof(float));
    if (!all_directions) {
        fprintf(stderr, "Error allocating direction buffer\n");
        return 1;
    }
    for (size_t i = 0; i < n_points; i++) {
        points[i].direction = all_directions + (i * D);
    }
    printf("main: allocated direction buffers\n");
    fflush(stdout);
    // Create the kd-tree
    kd_node *tree = kd_build(points, n_points, 0);
    printf("main: kd_build completed\n");
    fflush(stdout);

    // Add the max angle for every point
    updated_max_angles(tree, points, n_points, k, D);

    //Find the 20% barrier for the 20% lower angles and the numbe of border points
    float p20 = _percentile(points, n_points, 20.0f);
    int n_border_points = n_of_border_points(points, n_points, p20);
    point *border_points = malloc(n_border_points * sizeof(point));
    
    //Copy only border points
    copy_points_and_border(points, border_points, n_points, p20, -1);

    // Calculate eps value for dbscan
    float eps = compute_eps(border_points, n_border_points);

    //Compute angles for dbscan
    compute_all_directions(points, n_points, tree, k, D);
    printf("main: compute_all_directions done\n");
    fflush(stdout);
    
    //Assign border points a label
    dbscan(border_points, n_border_points, eps, 6);

    //Copy the label of border points to the actual points
    copy_points_and_border(points, border_points, n_points, p20, 1);

    // Assign non border points a label = -4
    for (int i = 0; i < n_points; i++) {
        if (points[i].max_angle >= p20) {
            points[i].labelll = -4;
        }
    }

    //Assigning of non border points
    //Create a kd-tree on the border points
    kd_node *border_tree = kd_build(border_points, n_border_points, 0);

    for (int i = 0; i < n_points; i++) {

        if (points[i].labelll != -4) {continue;}   // skip border points

        knn_item nearest[1];
        kd_knn(border_tree, points[i], 1, nearest); //Find the point nearest to the point in the kd_tree

        point *b = &nearest[0].point_;

        points[i].labelll = b->labelll;
    }

    //Final image creation
    int* finalImage = malloc(n_points * sizeof(int));
    for (int i = 0; i < n_points; i++) {
        finalImage[i] = points[i].labelll;
    }
    
    //Final image save
    save_final_image("data/final_image.bin", finalImage, n_points);
    
    // free memory
    kd_free(tree);
    free(all_directions);
    free(points);
    free(img->data);
    free(img);
    free(finalImage);
}
