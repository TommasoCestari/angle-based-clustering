#ifndef SSSORTING_H
#define SSSORTING_H
#include "kd_tree.h"

static inline void swap(float *a, float *b);

static int partition(float *a, int left, int right, int pivot);

static void quickselect(float *a, int left, int right, int k);

float _percentile(const point* points, size_t number_of_points, float x_percent);

#endif
