#include "kd_tree.h"
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <kdtree.h> 

struct kdtree *create_kd_tree(int kd_tree_dim, ImageTensor* img_tensor){
    struct kdtree *tree = kd_create(kd_tree_dim);
    if (!tree) {
        fprintf(stderr, "Error: Could not create KD-tree.\n");
        return 1;
    }
    for(int i = 0; i < img_tensor->height; i++){
        for(int j = 0; j < img_tensor->width; j++){
            kd_insert(tree, img_tensor->data[(i * img_tensor->width + j) * img_tensor->channels], img_tensor->data[(i * img_tensor->width + j) * img_tensor->channels]);
        }
    }
    return tree;
    kd_free(tree);  
}

//float search_kNN(kdtree *tree, double query_point, int k){
//    struct kdres *results = kd_nearest_n(tree, query_point, k);
//
//    // 2. Check if any results were found
//    if (kd_res_size(results) > 0) {
//        printf("Found %d nearest points:\n", kd_res_size(results));
//
//        int rank = 1;
//        // 3. Iterate through the result set (struct kdres)
//        while (!kd_res_end(results)) {
//            // Retrieve the data for the current item
//            // NOTE: The data type depends on what you inserted (in your case, likely double*)
//            double *neighbor_data = (double*)kd_res_item_data(results);
//
//            printf("  %d. (Distance: %.4f) Point: ", rank++, kd_res_item_dist(results));
//            print_point(neighbor_data);
//            printf("\n");
//
//            // Move to the next item in the result set
//            kd_res_next(results);
//        }
//    } else {
//        printf("No points found within the tree.\n");
//        return -1;
//    }
//    kd_res_free(result);
//}












