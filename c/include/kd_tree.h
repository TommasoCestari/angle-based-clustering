#ifndef KD_TREE_H
#define KD_TREE_H
#define D 15
typedef float* point_t;

typedef struct {
    point_t v;   // feature vector (pointer to array of floats)
    int x;
    int y;
    int axis;     // used ONLY during build
    float max_angle;
} point;


typedef struct kd_node {
    point point;
    int axis;
    struct kd_node *left;
    struct kd_node *right;
} kd_node;

typedef struct {
    point point_;
    float dist2;
} knn_item;

void kd_knn(const kd_node *root, point query, int k, knn_item *out);
//int compare_points(const void *a, const void *b);

/* API */
kd_node* kd_create_node(point point, int axis);
kd_node* kd_build(point *points_, size_t n, int depth);
void kd_free(kd_node *node);


#endif

