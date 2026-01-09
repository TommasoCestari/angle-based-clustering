#include <stdlib.h>
#include <stdio.h>
#include <stddef.h>   // for size_t
#include "kd_tree.h"
#define D 15   // number of dimensions

//current_axis is global (NOT thread-safe)
static int current_axis;

// Function to create a new node
kd_node* kd_create_node(point_t point, int axis) {
    kd_node* newNode = malloc(sizeof *newNode);
    if (!newNode) {
        perror("malloc");
        exit(EXIT_FAILURE);
    }

    newNode->point = point;
    newNode->axis = axis;
    newNode->left = NULL;
    newNode->right = NULL;

    return newNode;
}

int cmp_points_by_axis(const void *a, const void *b) {
    // a and b point to elements of the array (point_t)
    const point_t pa = *(const point_t *)a;
    const point_t pb = *(const point_t *)b;

    if (pa[current_axis] < pb[current_axis]) return -1;
    if (pa[current_axis] > pb[current_axis]) return  1;
    return 0;
}

kd_node* kd_build(point_t *points, size_t n, int depth) {
    // Base case 1: no points
    if (n == 0)
        return NULL;

    // Choose axis based on depth
    int axis = depth % D;

    // Base case 2: single point → leaf
    if (n == 1) {
        return kd_create_node(points[0], axis);
    }

    // Sort points by current axis
    current_axis = axis;
    qsort(points, n, sizeof(point_t), cmp_points_by_axis);

    // Choose median
    size_t median = n / 2;

    // Create node from median point
    kd_node *node = kd_create_node(points[median], axis);

    // Recursively build subtrees
    node->left  = kd_build(points, median, depth + 1);
    node->right = kd_build(points + median + 1, n - median - 1, depth + 1);

    return node;
}

void kd_free(kd_node *node) {
    if (node == NULL)
        return;

    kd_free(node->left);
    kd_free(node->right);
    free(node);
}

static float dist2(point_t a, point_t b)
{
    float d = 0.0f;
    for (int i = 0; i < D; i++) {
        float diff = a[i] - b[i];
        d += diff * diff;
    }
    return d;
}

static void knn_insert(knn_item *list, int *count, int k,
                       point_t point, float dist2)
{
    int i = *count;

    if (i < k) {
        list[i].point = point;
        list[i].dist2 = dist2;
        (*count)++;
    } else if (dist2 >= list[k-1].dist2) {
        return; // worse than worst
    } else {
        list[k-1].point = point;
        list[k-1].dist2 = dist2;
    }

    // insertion sort (small k → cheap)
    for (int j = *count - 1; j > 0; j--) {
        if (list[j].dist2 < list[j-1].dist2) {
            knn_item tmp = list[j];
            list[j] = list[j-1];
            list[j-1] = tmp;
        }
    }
}

static void kd_knn_search(kd_node *node,
                          point_t query,
                          knn_item *best,
                          int *count,
                          int k)
{
    if (!node) return;

    //float d = dist2(query, node->point);
    //knn_insert(best, count, k, node->point, d);
    // Do not include the starting point
    if (node->point != query) {
        float d = dist2(query, node->point);
        knn_insert(best, count, k, node->point, d);
    }



    int axis = node->axis;
    float diff = query[axis] - node->point[axis];

    kd_node *near = diff < 0 ? node->left  : node->right;
    kd_node *far  = diff < 0 ? node->right : node->left;

    kd_knn_search(near, query, best, count, k);

    // Prune?
    if (*count < k || diff*diff < best[*count - 1].dist2) {
        kd_knn_search(far, query, best, count, k);
    }
}

void kd_knn(kd_node *root,
            point_t query,
            int k,
            knn_item *out)
{
    int count = 0;
    kd_knn_search(root, query, out, &count, k);
}





