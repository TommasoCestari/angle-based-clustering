#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <stdint.h>
#include <mpi.h>
#include "kd_tree.h"
#include "DBSCAN.h"
#include "knn_operations.h"
#include "non_border_assigning.h"

void non_border_points_assignment(point* points, const kd_node* border_tree, size_t n_points){

    int world_size, world_rank;
    MPI_Comm_size(MPI_COMM_WORLD, &world_size);
    MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);

    //Find the starting point(start[]) and the number of iterations(size[]) for every process
    int size[world_size], start[world_size];
    if (world_rank == 0) { //Let rank 0 find the start and n° of iterations
        int remainder = n_points % world_size;
        start[0] = 0;

        for (int p = 0; p < world_size; p++){
            if(p != 0) start[p] = start[p - 1] + size[p - 1];
            size[p] = (int)n_points / world_size;
            if (p < remainder) size[p]++;
        }

    }

    //Send the array of results to the other processes
    MPI_Bcast(size, world_size, MPI_INT, 0, MPI_COMM_WORLD);
    MPI_Bcast(start, world_size, MPI_INT, 0, MPI_COMM_WORLD);


    //Every rank calculates its part
    int *label = malloc(n_points * sizeof(int));
    if (!label) {
        fprintf(stderr, "ERROR: malloc failed in non_border_points_assignment\n");
        MPI_Abort(MPI_COMM_WORLD, 1);
    }
    // initialize to a sentinel (keep existing labels for border points)
    for (size_t i = 0; i < n_points; i++) label[i] = points[i].labelll;

    for (size_t i = start[world_rank]; i < (start[world_rank] + size[world_rank]); i++){
        if (points[i].labelll != -4) { continue; } // skip border points

        knn_item nearest[1];
        kd_knn(border_tree, points[i], 1, nearest); //Find the point nearest to the point in the kd_tree

        point *b = &nearest[0].point_;
        label[i] = b->labelll;
    }

    //Every rank sends the part that it did to every other rank
    //send local chunk starting at &label[start[world_rank]]
    MPI_Allgatherv(&label[start[world_rank]], size[world_rank], MPI_INT,
        label, size, start, MPI_INT, MPI_COMM_WORLD);

    for (int i = 0; i < n_points; i++) {
        points[i].labelll = label[i];
    }

    free(label);
}