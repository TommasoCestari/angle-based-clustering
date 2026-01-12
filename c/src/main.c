#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "tiff_image_vectorization.h"
#include "kd_tree.h"
#include "knn_operations.h"
#include "sorting.h"
#define k 5


int main(int argc, char *argv[]) {
    // Tensorize image
    ImageTensor* img = load_tiff_as_tensor("data/sentinel_tensor_10m.tiff");
    int width = img->width; int height = img->height;
    if (!img) {
        printf("Error loading TIFF\n");
        return 1;
    }

    // Allocate memory for pixel pointers
    size_t n_points = (size_t)img->width * img->height;
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
    // Create the kd-tree
    kd_node *tree = kd_build(points, n_points, 0);

    // Print results in a txt file
    FILE *file_pointer;
    file_pointer = fopen("text.txt", "w");
    if (file_pointer == NULL) {
        printf("Error opening the file!\n");
        return 1; 
    }

    // Add the max angle for every point
    updated_max_angles(tree, points, n_points, k, D);

    // Find the number of the 20% barrier
    float points_copy[n_points];
    for (int i = 0; i < n_points; i++){
        if(!(i % width)){fprintf(file_pointer, "\n");}
        double angle_max_degrees = (points[i].max_angle)*180/3.1415; // (*points[i].v)*180/3.1415
        fprintf(file_pointer, "[%.2f°]", angle_max_degrees); 
        points_copy[i] = points[i].max_angle;
    }

    float p20 = _percentile(points_copy, width*height, 20.0f);

    fprintf(file_pointer, "\n/////////////////////\n20\% value of the barrier: %f°", (p20)*180/3.1415); //(p20)*180/3.1415
    fprintf(file_pointer, "\n");
    for (int i = 0; i < (n_points); i++){
        if(points[i].max_angle < p20) {
            if(!(i % width)){fprintf(file_pointer, "\n");}
            double angle_max_degrees = (points[i].max_angle)*180/3.1415;
            fprintf(file_pointer, "[%.2f°]", angle_max_degrees); 
        }
    }
    // Print results in a txt file

    fclose(file_pointer);

    // free memory
    kd_free(tree);
    free(points);
    free(img->data);
    free(img);
}
