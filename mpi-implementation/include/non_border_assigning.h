#ifndef NON_BORDER_ASSIGNING_H
#define NON_BORDER_ASSIGNING_H
#include <math.h>
#include "kd_tree.h"

void non_border_points_assignment(point* points, const kd_node* border_tree, size_t n_points);
void non_border_points_assignment_2(point* points, const kd_node* border_tree, size_t n_points, label* local_labels);
void get_local_chunk(long int n_points, int* local_size, int* local_start);
void data_transfer(int world_size, int world_rank, int image_width, int image_height, 
                    int n_total_points, int* local_size, label** local_labels);
void reorder_and_print(int image_width, label* local_labels, int local_num_elements, 
                       char* img_path);
#endif
