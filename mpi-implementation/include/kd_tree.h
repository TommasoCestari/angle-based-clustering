#ifndef KD_TREE_H
#define KD_TREE_H
#define D 15

typedef struct point{
    float *v;   // feature vector (pointer to array of floats)
    int x;
    int y;
    int axis;     // used ONLY during build
    float max_angle;
    float mean_knn_dist;
    int labelll;
    float *direction;
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
float dist2(const point a, const point b);
//int compare_points(const void *a, const void *b);

/* API */
kd_node* kd_create_node(point point, int axis);
kd_node* kd_build(point *points_, size_t n, int depth);
void kd_free(kd_node *node);


#endif

