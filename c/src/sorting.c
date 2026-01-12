#include <stdlib.h>
#include <stdio.h>
#include "sorting.h"

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

float _percentile(float *a, int n, float x_percent) {
    if (n <= 0) return 0.0f;
    if (x_percent <= 0.0f) return a[0];
    if (x_percent >= 100.0f) return a[n - 1];

    int k = (int)(x_percent * (n - 1) / 100.0f);
    quickselect(a, 0, n - 1, k);
    return a[k];
}
