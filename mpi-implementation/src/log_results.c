#include <stdio.h>
#include <stdlib.h>
#include "log_results.h"

void log_results(char* path, int n, int k, float eps, int min_pts, int nodes,
                 double s1, double s2, double s3, double s4, double s5, 
                 double s6, double s7, double s8, double s9, double s10, double s11) {
    FILE *f = fopen(path, "a");
    if (!f) return;

    // Check if file is empty to write header
    fseek(f, 0, SEEK_END);
    if (ftell(f) == 0) {
        fprintf(f, "Points,K,MultEps,MinPts,Nodes,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,TotalTime\n");
    }

    // Use %f for doubles
    fprintf(f, "%d,%d,%.2f,%d,%d,%.4f,%.4f,%.4f,%.4f,%.4f,%.4f,%.4f,%.4f,%.4f,%.4f,%.4f\n",
            n, k, eps, min_pts, nodes, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11);
    
    fclose(f);
}