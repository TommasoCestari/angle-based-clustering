#include "tiff_image_vectorization.h"
#include <stdlib.h>
#include <stdio.h>

//Everything was checked and it works

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

    TIFF* tif = TIFFOpen(filename, "r");
    if (!tif) return NULL;

    // Check if data is float
    uint16_t bps, sampleformat, planar;

    TIFFGetField(tif, TIFFTAG_BITSPERSAMPLE, &bps);
    TIFFGetField(tif, TIFFTAG_SAMPLEFORMAT, &sampleformat);
    TIFFGetField(tif, TIFFTAG_PLANARCONFIG, &planar);

    if (bps != 32 || sampleformat != SAMPLEFORMAT_IEEEFP) {
        fprintf(stderr, "TIFF is not 32-bit float\n");
        TIFFClose(tif);
        return NULL;
    }

    if (planar != PLANARCONFIG_CONTIG) {    // If the way the data is stored in the tiff is not planar (is separate instead) code will not work
        fprintf(stderr, "Unsupported planar configuration\n");
        TIFFClose(tif);
        return NULL;
    }

    size_t total = (size_t)w * h * c; //Like int but used in c to store memory size parameters

    ImageTensor* img = malloc(sizeof(ImageTensor));
    if (!img) {
        TIFFClose(tif);
        return NULL;
    }
    img->width = w;
    img->height = h;
    img->channels = c;
    img->data = malloc(total * sizeof(float));
    if (!img->data) {
        free(img);
        TIFFClose(tif);
        return NULL;
    }

    float* scanline = malloc(TIFFScanlineSize(tif));
    if (!scanline) {
        free(img->data);
        free(img);
        TIFFClose(tif);
        return NULL;
    }

    for (int y = 0; y < h; y++) {     //Scan row by row and memorize the value of the image into the tensor
        TIFFReadScanline(tif, scanline, y, 0);

        for (int x = 0; x < w; x++) {
            for (int k = 0; k < c; k++) {
                img->data[(y * w + x) * c + k] =
                    (scanline)[x * c + k];
            }
        }
    }

    free(scanline);
    TIFFClose(tif);

    return img;
}