#ifndef TIFF_IMAGE_VECTORIZATION_H
#define TIFF_IMAGE_VECTORIZATION_H
#include <tiffio.h>

typedef struct {
    uint32_t width;
    uint32_t height;
    uint16_t channels;
    float* data;
} ImageTensor;

int read_tiff_info(const char* filename,
                   uint32_t* width,
                   uint32_t* height,
                   uint16_t* channels);

ImageTensor* load_tiff_as_tensor(const char* filename);

#endif
