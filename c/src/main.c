#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "tiff_image_vectorization.h"
#include "kd_tree.h"
#include "knn_operations.h"
#define D 15   // number of dimensions


int main(int argc, char *argv[]) {
    // Tensorize image
    ImageTensor* img = load_tiff_as_tensor("data/sentinel_tensor_10m.tiff");

    if (!img) {
        printf("Error loading TIFF\n");
        return 1;
    }

    // KD tree creation and assigning
    size_t n_points = (size_t)img->width * img->height;
    point_t *points = malloc(n_points * sizeof(point_t)); // Allocate memory for pointers
    if (!points) {
        perror("malloc");
        return 1;
    }

    for (size_t i = 0; i < n_points; i++) {
        points[i] = &img->data[i * img->channels];
    }

    kd_node *tree = kd_build(points, n_points, 0);

    // Nearest neighbour algorithm test
    int y = 10, x = 20;
    point_t query =
        &img->data[(y * img->width + x) * img->channels];

    int k = 5;
    knn_item neighbors[5];

    kd_knn(tree, query, k, neighbors);

    // Print results in a txt file
    FILE *file_pointer;
    file_pointer = fopen("text.txt", "w");
    if (file_pointer == NULL) {
        printf("Error opening the file!\n");
        return 1; 
    }
    fprintf(file_pointer,"KD-tree built with %zu points (%dx%d pixels, D=%d)\n",
            n_points, img->width, img->height, D);
    for (int i = 0; i < k; i++) {
        fprintf(file_pointer, "Neighbor %d: [", i);
        for (int d = 0; d < D; d++) {
            fprintf(file_pointer,"%f", neighbors[i].point[d]);
            if (d < D - 1) fprintf(file_pointer,", ");
        }
        fprintf(file_pointer, "] dist2 = %f\n", neighbors[i].dist2);
    }

    fprintf(file_pointer, "\n ///////////////////// \n");
    float angles[k];
    vector_angle_result(query, neighbors , k, D, &angles[0]);
    double degrees;
    fprintf(file_pointer,"[");
    for (int i = 0; i < k; i++) {
        degrees = angles[i]*180/3.14159;
            fprintf(file_pointer," %f (%.1f°), ", angles[i], degrees);
            if (i == (k-1)) {fprintf(file_pointer,"]");}
        }

    fclose(file_pointer);

    // free memory
    kd_free(tree);
    free(points);
    free(img->data);
    free(img);
}
