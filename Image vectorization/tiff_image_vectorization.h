#ifndef TIFF_IMAGE_VECTORIZATION_H
#define TIFF_IMAGE_VECTORIZATION_H
#include <tiffio.h>

typedef struct {
    int width;
    int height;
    int channels;
    float* data;
} ImageTensor;

int read_tiff_info(const char* filename,
                   int* width,
                   int* height,
                   int* channels);

ImageTensor* load_tiff_as_tensor(const char* filename);

#endif
