#include <stdio.h>
#include <stdlib.h>
#include "tiff_image_vectorization.h"

int main(int argc, char *argv[]) {
    ImageTensor* img = load_tiff_as_tensor("../sentinel_tensor_10m.tiff");

    if (!img) {
        printf("Error loading TIFF\n");
        return 1;
    }

    printf("Width = %u\n", img->width);
    printf("Height = %u\n", img->height);
    printf("Channels = %u\n", img->channels);

    
    
    FILE *file_pointer;
    file_pointer = fopen("text.txt", "w");
    if (file_pointer == NULL) {
        printf("Error opening the file!\n");
        // Exit with an error code
        return 1; 
    }

    // Example: get pixel (y=10, x=20), channel 3
    float val = img->data[(10 * img->width + 20) * img->channels + 3];
    fprintf(file_pointer, "\nPixel value in y=10, x=20: %f\n", val);
    
    fclose(file_pointer);

    // free memory
    free(img->data);
    free(img);
}
