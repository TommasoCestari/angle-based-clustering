#include <stdlib.h>
#include <stdio.h>
#include <stddef.h>   // for size_t
#include "kd_tree.h"
#define D 15

static int current_axis;

// Function to create a new node
kd_node* kd_create_node(point point_, int axis) {
    kd_node* newNode = malloc(sizeof *newNode);
    if (!newNode) {
        perror("malloc");
        exit(EXIT_FAILURE);
    }

    newNode->point = point_;
    newNode->point.axis = axis;
    newNode->left = NULL;
    newNode->right = NULL;

    return newNode;
}

int compare_points(const void *a, const void *b)
{
    const point *pa = (const point *)a;
    const point *pb = (const point *)b;

    if (pa->v[current_axis] < pb->v[current_axis]) return -1;
    if (pa->v[current_axis] > pb->v[current_axis]) return  1;
    return 0;
}


kd_node* kd_build(point *points_, size_t n, int depth)
{
    if (n == 0) return NULL;

    int axis = depth % D;
    current_axis = axis; // Set before qsort

    qsort(points_, n, sizeof(point), compare_points);

    size_t median = n / 2;

    /* Create node from the median element (use median, not first element) */
    kd_node *node = kd_create_node(points_[median], axis);

    node->left  = kd_build(points_, median, depth + 1);
    node->right = kd_build(points_ + median + 1, n - median - 1, depth + 1);

    return node;
}


void kd_free(kd_node *node) {
    if (node == NULL)
        return;

    kd_free(node->left);
    kd_free(node->right);
    free(node);
}

float dist2(const point a, const point b)
{
    float d = 0.0f;
    for (int i = 0; i < D; i++) {
        float diff = a.v[i] - b.v[i];
        d += diff * diff;
    }
    return d;
}

static void knn_insert(knn_item *list, int *count, int k,
                       point point_, float dist2)
{
    int i = *count;

    if (i < k) {
        list[i].point_ = point_;
        list[i].dist2 = dist2;

        (*count)++;
    } else if (dist2 >= list[k-1].dist2) {
        return; // worse than worst
    } else {
        list[k-1].point_ = point_;
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

static void kd_knn_search(const kd_node *node,
                          point query,
                          knn_item *best,
                          int *count,
                          int k)
{
    if (!node) return;

    //float d = dist2(query, node->point);
    //knn_insert(best, count, k, node->point, d);
    // Do not include the starting point
    if (node->point.x != query.x || node->point.y != query.y) {
        float d = dist2(query, node->point);
        knn_insert(best, count, k, node->point, d);
    }



    /* Use the splitting axis coordinate difference between query and node */
    int axis = node->point.axis;
    float diff = query.v[axis] - node->point.v[axis];

    const kd_node *near = diff < 0 ? node->left  : node->right;
    const kd_node *far  = diff < 0 ? node->right : node->left;

    kd_knn_search(near, query, best, count, k);

    // Prune?
    if (*count < k || diff*diff < best[*count - 1].dist2) {
        kd_knn_search(far, query, best, count, k);
    }
}


/* Finds the k nearest neighbors of query in the kd-tree rooted at root and  
*  writes them as knn_item structs into out
*/
void kd_knn(const kd_node *root, const point query, int k, knn_item *out)
{
    int count = 0;
    kd_knn_search(root, query, out, &count, k);
}





