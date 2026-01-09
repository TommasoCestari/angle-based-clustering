#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "knn_operations.h"
#include "kd_tree.h"

const float PI_F = 3.14159265358979323846f;

void vector_subtraction(const float* vector_1, const float* vector_2, float* result_vector, int dims) {
    for(int i = 0; i < dims; i++) {
        result_vector[i] = vector_1[i] - vector_2[i];
    }
}

float vector_magnitude(const float* vector, int dims) { 
    float sum = 0.0f;
    for (int i = 0; i < dims; i++) {
        sum += vector[i] * vector[i];
    }
    return sqrtf(sum); //sqrt() but for float values
}

float vector_dot_product(const float* vector_1, const float* vector_2, int dims) {
    float sum = 0.0f;
    for (int i = 0; i < dims; i++) {
        sum += vector_1[i] * vector_2[i];
    }
    return sum;
}

float vector_compute_angle(const float* vector_1, const float* vector_2, int dims) {
    float dot = vector_dot_product(vector_1, vector_2, dims);
    float a_magnitude = vector_magnitude(vector_1, dims);
    float b_magnitude = vector_magnitude(vector_2, dims);

    if (a_magnitude == 0.0f || b_magnitude == 0.0f) return (float)PI_F;

    float cosine_sim = dot / (a_magnitude * b_magnitude);
    // Clamp to [-1, 1] to handle floating point errors
    if (cosine_sim > 1.0f) cosine_sim = 1.0f;
    if (cosine_sim < -1.0f) cosine_sim = -1.0f;
    
    return acosf(cosine_sim);
}

void vector_mean_of_neighbors(const knn_item *neighbors , int k, float* vector_mean, int dims){
    // Mean vector initialization
    for (int d = 0; d < dims; d++) {
        vector_mean[d] = 0.0f;
    }

    // Do the mean for every dimention
    for (int d = 0; d < dims; d++){
        for (int i = 0; i < k; i++) {
            vector_mean[d] += neighbors[i].point[d];
        }
        vector_mean[d] = vector_mean[d]/k;
    }
}

void vector_angle_result(const float* query_point, const knn_item *neighbors , int k, int dims, float *angles){
    // Creatimg the mean of the neighbors
    float vector_mean[dims]; 
    vector_mean_of_neighbors(neighbors, k, &vector_mean[0], dims);
    // Vectorization of the mean of the neighbors
    float mean_vector[dims];
    for (int d = 0; d < dims; d++) {
        mean_vector[d] = vector_mean[d] - query_point[d];
    }

    float neighbors_vector[k][dims];
    // Vectorization of the neighbors
    for (int d = 0; d < dims; d++){
        for (int i = 0; i < k; i++) {
            neighbors_vector[i][d] = neighbors[i].point[d] - query_point[d];
        }
    }

    for (int i = 0; i < k; i++) {
        angles[i] = vector_compute_angle(mean_vector, neighbors_vector[i], dims);
    }

}






