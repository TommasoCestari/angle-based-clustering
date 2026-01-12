#ifndef SSSORTING_H
#define SSSORTING_H

static inline void swap(float *a, float *b);

static int partition(float *a, int left, int right, int pivot);

static void quickselect(float *a, int left, int right, int k);

float _percentile(float *a, int n, float x_percent);

#endif
