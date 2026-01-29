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
    
    return n_border_points;
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

    if (a_magnitude == 0.0f || b_magnitude == 0.0f) return (float)PI_F; // return pi to indicate undefined angle

    float cosine_sim = dot / (a_magnitude * b_magnitude);
    // Clamp to [-1, 1] to handle floating point errors
    if (cosine_sim > 1.0f) cosine_sim = 1.0f;
    if (cosine_sim < -1.0f) cosine_sim = -1.0f;
    
    return acosf(cosine_sim);
}


//Compute the mean feature vector of the provided neighbors.
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


 /* For a query point, find k nearest neighbors, compute the mean neighbor vector,
 * construct mean-centered vectors and compute angles between the mean vector and each neighbor vector.
 */
void vector_angle_result(point* query_point, const kd_node* tree, int k, int dims, float *angles){
    
    // Searching the neighbors of the query_point
    knn_item neighbors[k];
    kd_knn(tree, *query_point, k, neighbors); //fills the provided array neighbors with up to k nearest neighbors to the query, sorted by increasing distance

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
        mean_distance += sqrtf(dist2(*query_point, neighbors[i].point_));
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


/*
 * For each query point, compute the maximum angle between query_to_centroid vector
 * and its k nearest neighbors, store it in points[i].max_angle.
 */
void updated_max_angles(const kd_node* tree, point* points, size_t n_points, int k, int dims){

    float angles[k];
    // Print progress every 1% (or every iteration if n_points < 100)
    size_t progress_interval = (n_points >= 100) ? n_points/100 : 1;
    
    for (size_t i = 0; i < n_points; i++){

        //Print the progress
        if ((i % progress_interval) == 0 || i == n_points - 1) {
            float percent = (float)(i + 1) / n_points * 100.0f;
            printf("\rUpdated_max_angles: %.1f%% (%zu/%zu)", percent, i + 1, n_points);
            fflush(stdout); // Force the output to show immediately
        }
        
        vector_angle_result(&points[i], tree, k, dims, angles);

        float max = angles[0];
        for(int j=1; j<k; j++) {
            if(angles[j] > max) max = angles[j];}
        points[i].max_angle = max;
    }
    printf("\r(3/11) Updated_max_angles: 100%% (%zu/%zu)\n", n_points, n_points);
    fflush(stdout); // Force the output to show immediately

}





