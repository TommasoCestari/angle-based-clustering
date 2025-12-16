#include "tiff_image_vectorization.h"
#include <math.h>
#include <stdio.h>
#include "clustering.h"

float v1[15] = {
    0.2f, 0.7f, 0.68f, 0.1f, 0.4f,
    0.56f, 0.87f, 0.43f, 0.51f, 0.23f,
    0.7f, 0.41f, 0.83f, 0.24f, 0.34f
};

float v2[15] = {
    0.12f, 0.85f, 0.33f, 0.64f, 0.29f,
    0.91f, 0.47f, 0.58f, 0.06f, 0.72f,
    0.38f, 0.99f, 0.21f, 0.54f, 0.67f
};

void subtract_vectors(const float* a, const float* b, float* result, int dims) {
    for(int i = 0; i < dims; i++) {
        result[i] = a[i] - b[i];
    }
}


float vector_magnitude(const float* v, int dims) { 
    float sum = 0.0f;
    for (int i = 0; i < dims; i++) {
        sum += v[i] * v[i];
    }
    return sqrtf(sum); //difference with sqrt() is that it accepts only floats?
}


float dot_product(const float* a, const float* b, int dims) {
    float sum = 0.0f;
    for (int i = 0; i < dims; i++) {
        sum += a[i] * b[i];
    }
    return sum;
}

float compute_angle(const float* a, const float* b, int dims) {
    float dot = dot_product(a, b, dims);
    float a_magnitude = vector_magnitude(a, dims);
    float b_magnitude = vector_magnitude(b, dims);

    if (a_magnitude == 0.0f || b_magnitude == 0.0f) return (float)PI_F;

    float cosine_sim = dot / (a_magnitude * b_magnitude);
    // Clamp to [-1, 1] to handle floating point errors
    if (cosine_sim > 1.0f) cosine_sim = 1.0f;
    if (cosine_sim < -1.0f) cosine_sim = -1.0f;
    
    return acosf(cosine_sim);
}


void compute_knn_mean(ImageTensor* img, int* neighbor_indices, int k, float* mean_output) {
    // Loop through neighbors, sum coordinates, divide by k
    int dims = img->channels; //to change with macro?
    for (int d = 0; d < dims; d++) {
        mean_output[d] = 0.0f;
    }

    for (int i = 0; i < k; i++) {  //sum up all neighbour vectors
        int idx = neighbor_indices[i];
        float* neighbour_vector = &img->data[idx * dims];
        for (int j = 0; j < dims; j++) {
            mean_output[j] += neighbour_vector[j];
        }
    }

    for (int i = 0; i < dims; i++) {
        mean_output[i] /= (float)k;
    }
}

int main() {
    float result[15];
    subtract_vectors(v1, v2, result, 15);
    printf("Difference Vector:\n");
    for (int i = 0; i < 15; i++) {
        printf("%f ", result[i]);
    }
    printf("\n");
}
