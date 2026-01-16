#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <stdint.h>
#include "kd_tree.h"
#include "DBSCAN.h"
#include "knn_operations.h"

#define UNVISITED -1
#define NOISE     -2
#define D 15

void copy_points_and_border (point* points, point* border_points, int n_points, float p20, int a){
    if(a == 1){
        int b = 0;
        for (int i = 0; i < n_points; i++) {
            if (points[i].max_angle < p20) {
                points[i].labelll = border_points[b++].labelll;
            }
        }
    } else if (a == -1){
        int b = 0;
        for (int i = 0; i < n_points; i++) {
            if (points[i].max_angle < p20) {
                border_points[b++] = points[i];
            }
        }
    } else {printf("Parametro non corretto, copia non avvenuta");}
}

float compute_eps(const point* border_points, int n_border)
{
    float sum = 0.0f;
    for (int i = 0; i < n_border; i++) {
        sum += border_points[i].mean_knn_dist;
    }
    return 0.25f * (sum / n_border);
}


static float euclidean_distance(const point *a, const point *b, int dims)
{
    float d = 0.0f;
    for (int i = 0; i < dims; i++) {
        float diff = a->v[i] - b->v[i];
        d += diff * diff;
    }
    return sqrtf(d);
}


int range_query(point *points, int n_points, int idx, float eps, int *neighbors)
{
    int count = 0;
    for (int i = 0; i < n_points; i++) {
        if (i == idx) continue;

        float d = modified_distance(&points[idx], &points[i], 0.2, D); //tra 0.2 e 5
        if (d <= eps) {
            neighbors[count++] = i;
        }
    }
    return count;
}


static void expand_cluster(point *points, int n_points, int idx, 
                            int cluster_id, float eps, int minPts)
{
    int *neighbors = malloc(n_points * sizeof(int));
    int *queue     = malloc(n_points * sizeof(int));

    int n_neighbors = range_query(points, n_points, idx, eps, neighbors);

    points[idx].labelll = cluster_id;

    int q_start = 0;
    int q_end   = 0;

    for (int i = 0; i < n_neighbors; i++) {
        if (q_end < n_points) {
            queue[q_end++] = neighbors[i];
        }
    }

    while (q_start < q_end) {
        int q = queue[q_start++];
        if (points[q].labelll == -3) {points[q].labelll = UNVISITED;}

        if (points[q].labelll == NOISE)
            points[q].labelll = cluster_id;

        if (points[q].labelll != UNVISITED)
            continue;

        points[q].labelll = cluster_id;

        int n_q_neighbors =
            range_query(points, n_points, q, eps, neighbors);

        if (n_q_neighbors >= minPts) {
            for (int i = 0; i < n_q_neighbors; i++) {
                int n = neighbors[i];
                if (points[n].labelll == UNVISITED && q_end < n_points) {
                    points[n].labelll = -3;
                    queue[q_end++] = n;
                }
            }
        }
    }

    free(neighbors);
    free(queue);
}


void dbscan(point *points, int n_points, float eps, int minPts)
{
    printf("dbscan start: n_points=%d, eps=%f, minPts=%d\n",
           n_points, eps, minPts);

    /* initialize labels */
    for (int i = 0; i < n_points; i++) {
        points[i].labelll = UNVISITED;
    }

    int cluster_id = 0;

    for (int i = 0; i < n_points; i++) {
        
        if (i % 1000 == 0) {
            printf("dbscan progress: i=%d\n", i);
            fflush(stdout);
        }

        if (points[i].labelll != UNVISITED)
            continue;

        int *neighbors = malloc(n_points * sizeof(int));
        int n_neighbors = range_query(points, n_points, i, eps, neighbors);

        if (n_neighbors < minPts) {
            points[i].labelll = NOISE;
            free(neighbors);
            continue;
        }

        printf("dbscan: seed point %d has %d neighbors -> expanding cluster %d\n",
               i, n_neighbors, cluster_id);
        fflush(stdout);

        expand_cluster(points, n_points,
                       i, cluster_id, eps, minPts);

        printf("dbscan: finished cluster %d\n", cluster_id);
        fflush(stdout);

        cluster_id++;
        free(neighbors);
    }

    printf("dbscan done: found %d clusters\n", cluster_id);
}


//Save image labels data on external file
void save_final_image(const char* filename, int* finalImage, size_t n_points) {
    FILE* f = fopen(filename, "wb");
    if (!f) {
        perror("Cannot open file to save finalImage");
        return;
    }
    // save as 16-bit unsigned integers
    for (size_t i = 0; i < n_points; i++) {
        uint16_t val = (finalImage[i] < 0) ? 0 : (uint16_t)(finalImage[i] + 1);
        fwrite(&val, sizeof(uint16_t), 1, f);
    }
    fclose(f);
}



//Modified distance for DBSCAN
void compute_point_direction(point* query_point, const kd_node* tree, int k, int dims)
{
    // --- 1. Find kNN ---
    knn_item neighbors[k];
    kd_knn(tree, *query_point, k, neighbors);

    // --- 2. Compute mean direction vector = mean(neighbor - query) ---
    for (int d = 0; d < dims; d++) {
        query_point->direction[d] = 0.0f;
    }

    for (int i = 0; i < k; i++) {
        for (int d = 0; d < dims; d++) {
            query_point->direction[d] +=
                neighbors[i].point_.v[d] - query_point->v[d];
        }
    }

    for (int d = 0; d < dims; d++) {
        query_point->direction[d] /= k;
    }
}


void compute_all_directions(point* points,
                            int n_points,
                            const kd_node* tree,
                            int k,
                            int dims)
{
    for (int i = 0; i < n_points; i++) {
        compute_point_direction(&points[i], tree, k, dims);
    }
}


float modified_distance(const point *a, const point *b, float sigma_mod, int dims)
{
    // --- 1. Euclidean distance between points (feature space) ---
    float d_eucl = euclidean_distance(a, b, dims);

    // --- 2. Cosine of angle between direction vectors ---
    float mag_a = vector_magnitude(a->direction, dims);
    float mag_b = vector_magnitude(b->direction, dims);

    float cos_theta = 0.0f;

    if (mag_a > 1e-8f && mag_b > 1e-8f) {
        cos_theta = vector_dot_product(a->direction, b->direction, dims)
                    / (mag_a * mag_b);

        // numerical safety
        if (cos_theta >  1.0f) cos_theta =  1.0f;
        if (cos_theta < -1.0f) cos_theta = -1.0f;
    }

    // --- 3. Direction-angle modifier (Eq. 2) ---
    float factor = 1.0f + ((sigma_mod - 1.0f) / 3.1415) * cos_theta;

    // --- 4. Final modified distance ---
    return d_eucl * factor;
}
