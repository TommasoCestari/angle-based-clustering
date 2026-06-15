#include <stdio.h>
#include <stdlib.h>
#include "log_results.h"

void log_results(char* path, int n, int k, float eps, int min_pts, int nodes,
                 double s1, double s2, double s3, double s3_5, double s4, 
                 double s5, double s6, double s7, double s7_5, double s8, 
                 int num_clusters, char* cpu_info) {
    FILE *f = fopen(path, "a");
    if (!f) return;

    // Check if file is empty to write header
    fseek(f, 0, SEEK_END);
    if (ftell(f) == 0) {
        fprintf(f, "Points,K,MultEps,MinPts,Nodes,S1-Parsing,S2-Kd-tree,S3-Up max angles,"
                "S3.5-AllGather angles,S4-EPS&other,S5-DBSCAN,S6-Border-tree,S7-Core points,"
                "S7.5-AlltoAll,S8-File print/Total Time,NumberClusters,CPUinfo\n");
    }

    fprintf(f, "%d,%d,%.2f,%d,%d,%.4f,%.4f,%.4f,%.4f,%.4f,%.4f,%.4f,%.4f,%.4f,%.4f,%d,%s\n",
            n, k, eps, min_pts, nodes, s1, s2, s3, s3_5, s4, s5, s6, s7, s7_5, s8, num_clusters, cpu_info);
    
    fclose(f);
}