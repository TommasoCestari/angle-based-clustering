#ifndef KD_TREE_H
#define KD_TREE_H

typedef float* point_t;

typedef struct kd_node {
    point_t point;
    int axis;
    struct kd_node *left;
    struct kd_node *right;
} kd_node;

typedef struct {
    point_t point;
    float dist2;
} knn_item;

void kd_knn(kd_node *root,
            point_t query,
            int k,
            knn_item *out);


/* API */
kd_node* kd_create_node(point_t point, int axis);
kd_node* kd_build(point_t *points, size_t n, int depth);
void kd_free(kd_node *node);


#endif
