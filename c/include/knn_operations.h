#ifndef KNN_OPERATIONS_H
#define KNN_OPERATIONS_H
#include <math.h>
#include <stdbool.h>
#include "kd_tree.h"

//const float PI_F = 3.14159265358979323846f;

typedef struct {
    int* cluster_ids;      // DBSCAN assignment
    double* border_degrees; // computed angles
    bool* is_border;       // border flags
    int num_pixels;
} ClusteringResults;

void vector_subtraction(const float* vector_1, const float* vector_2, float* result_vector, int dims);

float vector_magnitude(const float* vector, int dims);

float vector_dot_product(const float* vector_1, const float* vector_2, int dims);

float vector_compute_angle(const float* vector_1, const float* vector_2, int dims);

void vector_mean_of_neighbors(const knn_item *neighbors , int k, float* vector_mean, int dims);

void vector_angle_result(const float* query_point, const knn_item *neighbors , int k, int dims, float *angles);

#endif

