#include "tiff_image_vectorization.h"
#include <stdlib.h>
#include <stdio.h>

int read_tiff_info(const char* filename, int* width, int* height, int* channels) {
    TIFF* tif = TIFFOpen(filename, "r");
    if (!tif) return 0;

    TIFFGetField(tif, TIFFTAG_IMAGEWIDTH, width);
    TIFFGetField(tif, TIFFTAG_IMAGELENGTH, height);
    TIFFGetField(tif, TIFFTAG_SAMPLESPERPIXEL, channels);

    TIFFClose(tif);
    return 1;
}

ImageTensor* load_tiff_as_tensor(const char* filename)
{
    int w, h, c;

    if (!read_tiff_info(filename, &w, &h, &c))
        return NULL;

    size_t total = (size_t)w * h * c; //Like int but used in c to store memory size parameters

    ImageTensor* img = malloc(sizeof(ImageTensor));
    img->width = w;
    img->height = h;
    img->channels = c;
    img->data = malloc(total * sizeof(float));

    TIFF* tif = TIFFOpen(filename, "r");
    if (!tif) return NULL;

    int* scanline = malloc(TIFFScanlineSize(tif));

    for (int y = 0; y < h; y++) {     //Scan row by row and memorize the value of the image into the tensor
        TIFFReadScanline(tif, scanline, y, 0);

        for (uint32_t x = 0; x < w; x++) {
            for (int k = 0; k < c; k++) {
                img->data[(y * w + x) * c + k] =
                    ((float*)scanline)[x * c + k];
            }
        }
    }

    free(scanline);
    TIFFClose(tif);

    return img;
}