#ifndef TIFF_IMAGE_VECTORIZATION_H
#define TIFF_IMAGE_VECTORIZATION_H
#include <tiffio.h>

typedef struct {
    int width;
    int height;
    int channels;
    float* data;
} ImageTensor;

ImageTensor* load_tiff_as_tensor(const char* filename, int world_rank);

#endif