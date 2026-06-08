#ifndef LOG_RESULTS_H
#define LOG_RESULTS_H

#include <stdio.h>
#include <mpi.h>

void log_results(char* path, int n, int k, float eps, int min_pts, int nodes,
                 double s1, double s2, double s2_5, double s3, double s4, double s4_5, 
                 double s5, double s6, double s7, double s7_5, double s8, double s9, 
                 int num_clusters, char* cpu_info);

#endif