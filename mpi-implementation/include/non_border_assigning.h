#ifndef NON_BORDER_ASSIGNING_H
#define NON_BORDER_ASSIGNING_H
#include <math.h>
#include "kd_tree.h"

void non_border_points_assignment(point* points, const kd_node* border_tree, size_t n_points);

#endif