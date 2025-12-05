#include <stdio.h>
#include "tiff_reader.h"

int main(int argc, char *argv[]) {
    ImageTensor* img = load_tiff_as_tensor("C:\\Users\\andre\\Desktop\\HPC project\\Trento image\\sentinel_tensor_10m.tiff");

    if (!img) {
        printf("Error loading TIFF\n");
        return 1;
    }

    printf("Width = %u\n", img->width);
    printf("Height = %u\n", img->height);
    printf("Channels = %u\n", img->channels);

    // Example: get pixel (y=10, x=20), channel 3
    float val = img->data[(10 * img->width + 20) * img->channels + 3];

    // free memory
    free(img->data);
    free(img);
}
