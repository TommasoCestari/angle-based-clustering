#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "knn_operations.h"
#include "kd_tree.h"

extern int D;
const float PI_F = 3.14159265358979323846f;

size_t n_of_border_points(const point* points, size_t n_points, float percentile){
    size_t n_border_points = 0;

    for (size_t i = 0; i < (n_points); i++){
        if(points[i].max_angle < percentile) {
            n_border_points++;
        }
    }
    if (n_border_points == 0) {
        printf("ERROR: no border points found\n");
        return -1;
    } else {
        return n_border_points;
    }
}

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

void vector_mean_of_neighbors(const knn_item* neighbors , int k, int dims, float* vector_mean){
    // Mean vector initialization
    for (int d = 0; d < dims; d++) {
        vector_mean[d] = 0.0f;
    }

    // Do the mean for every dimention
    for (int d = 0; d < dims; d++){
        for (int i = 0; i < k; i++) {
            vector_mean[d] += neighbors[i].point_.v[d];
        }
        vector_mean[d] = vector_mean[d]/k;
    }
}

void vector_angle_result(point* query_point, const kd_node* tree, int k, int dims, float *angles){
    
    // Searching the neighbors of the query_point
    knn_item neighbors[k];
    kd_knn(tree, *query_point, k, neighbors);

    // Creating the mean of the neighbors of the query_point
    float vector_mean[dims]; 
    vector_mean_of_neighbors(neighbors, k, dims, vector_mean);

    // Vectorization of the mean of the neighbors (subtracting the query point to the mean of the neighbors)
    float mean_vector[dims];
    for (int d = 0; d < dims; d++) {
        mean_vector[d] = vector_mean[d] - query_point->v[d];
    }
    
    // Add the mean distance to the points for the esp in DBSCAN
    float mean_distance = 0;
    for (int i = 0; i < k; i++){
        mean_distance += dist2(*query_point, neighbors[i].point_);
    }
    mean_distance = mean_distance/k;
    query_point->mean_knn_dist = mean_distance;

    // Vectorization of the neighbors
    float neighbors_vector[k][dims];
    for (int d = 0; d < dims; d++){
        for (int i = 0; i < k; i++) {
            neighbors_vector[i][d] = neighbors[i].point_.v[d] - query_point->v[d];
        }
    }

    for (int i = 0; i < k; i++) {
        angles[i] = vector_compute_angle(mean_vector, neighbors_vector[i], dims);
    }

}

void updated_max_angles(const kd_node* tree, point* points, size_t n_points, int k, int dims){

    float angles[k];
    int j = n_points/100; //Just a counter for the print
    float l = 0; //Just a counter for the print

    for (size_t i = 0; i < n_points; i++){

        //Print the progress
        if ((i % j) == 0) {
            l += j;
            float m = l/n_points*100;
            if(m>100) {m = 100;}
            printf("\rUpdated_max_angles: %.1f\% (%d/%d)", m, i, n_points);
            fflush(stdout); // Force the output to show immediately
        }
        
        vector_angle_result(&points[i], tree, k, dims, angles);
        float max = angles[0];
        for(int i=1; i<k; i++) {if(angles[i] > max) max = angles[i];}
        points[i].max_angle = max;
    }
    printf("\r(3/11) Updated_max_angles: 100\% (%d/%d)\n", n_points, n_points);
    fflush(stdout); // Force the output to show immediately

}





