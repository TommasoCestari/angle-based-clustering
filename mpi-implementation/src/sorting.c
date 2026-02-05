#include <stdlib.h>
#include <stdio.h>
#include <mpi.h>
#include "sorting.h"
#include "kd_tree.h"


static inline void swap(float *a, float *b) {
    float t = *a; *a = *b; *b = t;
}

static int partition(float *a, int left, int right, int pivot) {
    float pv = a[pivot]; // pivot value
    swap(&a[pivot], &a[right]); // move pivot to the end

    int store = left;
    for (int i = left; i < right; i++)
        if (a[i] < pv)
            swap(&a[i], &a[store++]);

    swap(&a[store], &a[right]);
    return store; //  final position of the pivot in the array segment
}

static void quickselect(float *a, int left, int right, int k) {
    while (left < right) {
        int pivot = left + rand() % (right - left + 1); // right - left + 1 are the elements in the current subarray
        pivot = partition(a, left, right, pivot);

        if (k == pivot) return;
        if (k < pivot) right = pivot - 1;
        else left = pivot + 1;
    }
}
/*
After the first call to partition() we know that 
a[left .. p-1] < a[p]
a[p]           = pivot
a[p+1 .. right] >= a[p]
*/


float _percentile(const point* points, size_t number_of_points, float x_percent) {

    int world_rank;
    MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);

    //Routine checks to see if the input makes sense
    if (number_of_points == 0) {
        fprintf(stderr, "ERROR: [_percentile] no points detected\n");
        return 0.0f;
    }
    if (x_percent <= 0.0f) {
        fprintf(stderr, "ERROR: [_percentile] percentile less then 0\%\n");
        return 0.0f; 
    }
    if (x_percent >= 100.0f) {
        fprintf(stderr, "ERROR: [_percentile] percentile more then 100\%\n");
        return 0.0f; 
    }

    /*Since it's a fast calculation that uses all points at once it makes 
      little sense to parallelize it so everthing is done by rank 0 and 
      it's then shared to the other ranks through Bcast
    */
    float res = 0.0f;
    if (world_rank == 0){
        float *points_copy = malloc(number_of_points * sizeof(float)); //quickselect modifies the array in place, if we simply used points array we would lose the image structure 
        if (!points_copy) {
            fprintf(stderr, "ERROR: [_percentile] Failed to allocate memory for percentile calculation\n");
            return 1.0f; 
        }
        
        for (size_t i = 0; i < number_of_points; i++){
            points_copy[i] = points[i].max_angle; // points_copy is like points array but only with max_angle field
        }
        
        int k = (int)(x_percent * (number_of_points - 1) / 100.0f); // target index in the sorted array corresponding to the percentile
        quickselect(points_copy, 0, number_of_points - 1, k);
        res = points_copy[k];
        free(points_copy);
    }

    MPI_Bcast(&res, 1, MPI_FLOAT, 0, MPI_COMM_WORLD);

    return res; // returns the value of the k-th element (so its max_angle) in an array that is sorted until position k
}