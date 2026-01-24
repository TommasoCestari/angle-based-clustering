#include <stdlib.h>
#include <stdio.h>
#include "sorting.h"
#include "kd_tree.h"

extern int D;

static inline void swap(float *a, float *b) {
    float t = *a; *a = *b; *b = t;
}

static int partition(float *a, int left, int right, int pivot) {
    float pv = a[pivot];
    swap(&a[pivot], &a[right]);

    int store = left;
    for (int i = left; i < right; i++)
        if (a[i] < pv)
            swap(&a[i], &a[store++]);

    swap(&a[store], &a[right]);
    return store;
}

static void quickselect(float *a, int left, int right, int k) {
    while (left < right) {
        int pivot = left + rand() % (right - left + 1);
        pivot = partition(a, left, right, pivot);

        if (k == pivot) return;
        if (k < pivot) right = pivot - 1;
        else left = pivot + 1;
    }
}

float _percentile(const point* points, size_t number_of_points, float x_percent) {
    if (number_of_points <= 0) return 0.0f;

    float *points_copy = malloc(number_of_points * sizeof(float));
    if (!points_copy) {
        fprintf(stderr, "ERROR: Failed to allocate memory for percentile calculation\n");
        exit(EXIT_FAILURE);  // Or handle differently
    }

    for (size_t i = 0; i < number_of_points; i++){
        points_copy[i] = points[i].max_angle;
    }

    if (x_percent <= 0.0f) {
        float min_val = points_copy[0];
        for (size_t i = 1; i < number_of_points; i++) {
            if (points_copy[i] < min_val) min_val = points_copy[i];
        }
        free(points_copy);
        return min_val;
    }

    if (x_percent >= 100.0f) {
        // Find maximum
        float max_val = points_copy[0];
        for (size_t i = 1; i < number_of_points; i++) {
            if (points_copy[i] > max_val) max_val = points_copy[i];
        }
        free(points_copy);
        return max_val;
    }

    int k = (int)(x_percent * (number_of_points - 1) / 100.0f);
    quickselect(points_copy, 0, number_of_points - 1, k);
    float res = points_copy[k];
    free(points_copy);
    return res;
}
