#include <stdio.h>
#include "kd_tree.h"
#include "debug_utils.h"

#define D 15

// Print first N points
void debug_print_points(const point* points, size_t n, size_t max_print) {
    size_t to_print = (n < max_print) ? n : max_print;
    printf("\n=== First %zu points ===\n", to_print);
    for (size_t i = 0; i < to_print; i++) {
        printf("Point %zu: coords=(%d,%d) v[0]=%.3f v[1]=%.3f v[2]=%.3f\n",
               i, points[i].x, points[i].y,
               points[i].v[0], points[i].v[1], points[i].v[2]);
    }
}

// Print kd-tree structure (first few levels)
void debug_print_tree(const kd_node* node, int depth, int max_depth) {
    if (!node || depth > max_depth) return;
    
    for (int i = 0; i < depth; i++) printf("  ");
    printf("Depth %d, axis=%d, coords=(%d,%d), v[axis]=%.3f\n",
           depth, node->point.axis,
           node->point.x, node->point.y,
           node->point.v[node->point.axis]);
    
    debug_print_tree(node->left, depth + 1, max_depth);
    debug_print_tree(node->right, depth + 1, max_depth);
}

// Print max_angle statistics
void debug_max_angles(const point* points, size_t n) {
    float min_angle = 999.0f, max_angle = -999.0f, sum = 0.0f;
    int zero_count = 0;
    
    for (size_t i = 0; i < n; i++) {
        if (points[i].max_angle == 0.0f) zero_count++;
        if (points[i].max_angle < min_angle) min_angle = points[i].max_angle;
        if (points[i].max_angle > max_angle) max_angle = points[i].max_angle;
        sum += points[i].max_angle;
    }
    
    printf("\n=== Max Angle Statistics ===\n");
    printf("Min: %.4f, Max: %.4f, Mean: %.4f\n", min_angle, max_angle, sum / n);
    printf("Zero angles: %d (%.2f%%)\n", zero_count, 100.0f * zero_count / n);
}

// Print direction vector statistics
void debug_directions(const point* points, size_t n) {
    int null_count = 0, zero_count = 0;
    
    for (size_t i = 0; i < n; i++) {
        if (points[i].direction == NULL) {
            null_count++;
            continue;
        }
        
        float mag = 0.0f;
        for (int d = 0; d < D; d++) {
            mag += points[i].direction[d] * points[i].direction[d];
        }
        if (mag < 1e-10f) zero_count++;
    }
    
    printf("\n=== Direction Statistics ===\n");
    printf("NULL directions: %d\n", null_count);
    printf("Zero-magnitude directions: %d\n", zero_count);
}

// Print label distribution after DBSCAN
void debug_labels(const point* points, size_t n) {
    int noise = 0, unvisited = 0, clustered = 0;
    int max_label = -999;
    
    for (size_t i = 0; i < n; i++) {
        if (points[i].labelll == -2) noise++;
        else if (points[i].labelll == -1) unvisited++;
        else {
            clustered++;
            if (points[i].labelll > max_label) max_label = points[i].labelll;
        }
    }
    
    printf("\n=== Label Distribution ===\n");
    printf("Clusters: %d\n", max_label + 1);
    printf("Clustered points: %d (%.2f%%)\n", clustered, 100.0f * clustered / n);
    printf("Noise points: %d (%.2f%%)\n", noise, 100.0f * noise / n);
    printf("Unvisited: %d\n", unvisited);
}

// Test KNN on a single point
void debug_knn(const kd_node* tree, point query, int k) {
    knn_item neighbors[k];
    kd_knn(tree, query, k, neighbors);
    
    printf("\n=== KNN for point (%d,%d) ===\n", query.x, query.y);
    for (int i = 0; i < k; i++) {
        printf("  Neighbor %d: (%d,%d) dist2=%.3f\n",
               i, neighbors[i].point_.x, neighbors[i].point_.y,
               neighbors[i].dist2);
    }
}