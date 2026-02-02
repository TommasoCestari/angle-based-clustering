#ifndef DEBUG_UTILS_H
#define DEBUG_UTILS_H

#include <stddef.h> 
#include "kd_tree.h"

void debug_print_points(const point* points, size_t n, size_t max_print);
void debug_print_tree(const kd_node* node, int depth, int max_depth);
void debug_max_angles(const point* points, size_t n);
void debug_directions(const point* points, size_t n);
void debug_labels(const point* points, size_t n);
void debug_knn(const kd_node* tree, point query, int k);

#endif