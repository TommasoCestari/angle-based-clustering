#ifndef KNN_OPERATIONS_H
#define KNN_OPERATIONS_H
#include <math.h>
#include <stdbool.h>
#include "kd_tree.h"

typedef struct {
    float max_angle;
    float mean_knn_dist;
} uma_results;

size_t n_of_border_points(const point* points, size_t n_points, float percentile);

void vector_subtraction(const float* vector_1, const float* vector_2, float* result_vector, int dims);

float vector_magnitude(const float* vector, int dims);

float vector_dot_product(const float* vector_1, const float* vector_2, int dims);

float vector_compute_angle(const float* vector_1, const float* vector_2, int dims);

void vector_mean_of_neighbors(const knn_item* neighbors , int k, int dims, float* vector_mean);

void vector_angle_result(point* query_point, const kd_node* tree, int k, int dims, float *angles);

void updated_max_angles(const kd_node* tree, point* points, size_t n_points, int k, int dims, double* t2_5, double* t2_6);

#endif

