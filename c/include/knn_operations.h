#ifndef KNN_OPERATIONS_H
#define KNN_OPERATIONS_H
#include <math.h>
#include <stdbool.h>
#include "kd_tree.h"

//const float PI_F = 3.14159265358979323846f;

void vector_subtraction(const float* vector_1, const float* vector_2, float* result_vector, int dims);

float vector_magnitude(const float* vector, int dims);

float vector_dot_product(const float* vector_1, const float* vector_2, int dims);

float vector_compute_angle(const float* vector_1, const float* vector_2, int dims);

void vector_mean_of_neighbors(const knn_item* neighbors , int k, int dims, float* vector_mean);

void vector_angle_result(const point* query_point, const kd_node* tree, int k, int dims, float *angles);

void updated_max_angles(const kd_node* tree, point* points, int n_points, int k, int dims);
#endif

