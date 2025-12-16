#ifndef CLUSTERING_H
#define CLUSTERING_H
#include <math.h>
#include <stdbool.h>

const float PI_F = 3.14159265358979323846f;

typedef struct {
    int* cluster_ids;      // DBSCAN assignment
    double* border_degrees; // computed angles
    bool* is_border;       // border flags
    int num_pixels;
} ClusteringResults;

void subtract_vectors(const float* a, const float* b, float* result, int dims);

float vector_magnitude(const float* v, int dims);

float dot_product(const float* a, const float* b, int dims);

float compute_angle(const float* a, const float* b, int dims);

void compute_knn_mean(ImageTensor* img, int* neighbor_indices, int k, float* mean_output);

#endif