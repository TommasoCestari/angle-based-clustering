#include "kd_tree.h"
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <kdtree.h> // <-- The header for the C library

#define DIM 3

void print_point(double *point) {
    if (!point) {
        printf(" (NULL) ");
        return;
    }
    printf("(%.2f, %.2f, %.2f)", point[0], point[1], point[2]);
}

int main() {
    // --- 1. Initialization ---
    printf("--- KD-Tree Initialization ---\n");
    // Create an empty KD-tree instance for 3D points
    struct kdtree *tree = kd_create(DIM);
    if (!tree) {
        fprintf(stderr, "Error: Could not create KD-tree.\n");
        return 1;
    }
    printf("KD-Tree (Dimension: %d) created successfully.\n\n", DIM);

    // --- 2. Data Insertion ---
    printf("--- Data Insertion ---\n");

    // We will use double arrays for points, as required by this C library
    double p1[DIM] = {1.0, 2.0, 3.0};
    double p2[DIM] = {5.0, 4.0, 6.0};
    double p3[DIM] = {0.1, 0.1, 0.1};
    double p4[DIM] = {10.0, 5.0, 1.0};

    // The second argument to kd_insert is data, we'll just pass the point itself
    kd_insert(tree, p1, p1);
    printf("Inserted point: "); print_point(p1); printf("\n");

    kd_insert(tree, p2, p2);
    printf("Inserted point: "); print_point(p2); printf("\n");

    kd_insert(tree, p3, p3);
    printf("Inserted point: "); print_point(p3); printf("\n");

    kd_insert(tree, p4, p4);
    printf("Inserted point: "); print_point(p4); printf("\n");

    //printf("Total points in tree: %d\n\n", kd_count(tree));

    // --- 3. Nearest Neighbor Query ---
    printf("--- Nearest Neighbor Query ---\n");

    double query_point[DIM] = {0.0, 0.0, 0.0};
    printf("Searching for nearest neighbor to: "); print_point(query_point); printf("\n");

    // Perform the nearest neighbor search
    struct kdres *result = kd_nearest(tree, query_point);

    if (kd_res_size(result) > 0) {
        // Retrieve the data (which is the point array itself in this example)
        double *nearest_data = (double*)kd_res_item_data(result);

        printf("Found nearest point: ");
        print_point(nearest_data);
        printf("\n");
    } else {
        printf("No points found.\n");
    }

    // --- 4. Cleanup ---
    kd_res_free(result); // Free the query result set
    kd_free(tree);       // Free the entire KD-tree
    printf("\nCleanup complete.\n");

    return 0;
}