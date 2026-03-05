#ifndef DBSCAN_H
#define DBSCAN_H
#include "kd_tree.h"

void copy_points_and_border (point* points, point* border_points, int n_points, float p20, int a);

int range_query(point *points, int n_points, int idx, float eps, int *neighbors);

int dbscan(point *points, int n_points, float eps, int minPts);

float compute_eps(const point *border_points, size_t n_border);

void compute_point_direction(point* query_point, const kd_node* tree, int k, int dims);

void compute_all_directions(point* points, int n_points, const kd_node* tree, int k, int dims, double* t6_5);

float modified_distance(const point *a, const point *b, float sigma_mod, int dims);

void save_final_image(const char* filename, int* finalImage, size_t n_points);

void save_raw_15band( const char* filename, float* data, size_t total_elements);


#endif

