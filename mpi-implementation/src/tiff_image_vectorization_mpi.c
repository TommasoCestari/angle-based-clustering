#include "tiff_image_vectorization.h"
#include <stdlib.h>
#include <stdio.h>
#include <mpi.h>

ImageTensor* load_tiff_as_tensor(const char* filename, int world_rank)
{
    int w = 0, h = 0, c = 0;

    // Get the metadata throught rank 0
    if (world_rank == 0) {
        TIFF* tif = TIFFOpen(filename, "r");
        if (!tif) return NULL;

        TIFFGetField(tif, TIFFTAG_IMAGEWIDTH, &w);
        TIFFGetField(tif, TIFFTAG_IMAGELENGTH, &h);
        TIFFGetField(tif, TIFFTAG_SAMPLESPERPIXEL, &c);

        uint16_t bps, sampleformat, planar;
        TIFFGetField(tif, TIFFTAG_BITSPERSAMPLE, &bps);
        TIFFGetField(tif, TIFFTAG_SAMPLEFORMAT, &sampleformat);
        TIFFGetField(tif, TIFFTAG_PLANARCONFIG, &planar);

        if (bps != 32 || sampleformat != SAMPLEFORMAT_IEEEFP || planar != PLANARCONFIG_CONTIG) {
            fprintf(stderr, "Unsupported TIFF format (Not 32 bit float or not planar configuration)\n");
            TIFFClose(tif);
            return NULL;
        }

        TIFFClose(tif);
    }

    ImageTensor* img = NULL;

    if (world_rank == 0) {
        img = malloc(sizeof(ImageTensor));
        img->width = w;
        img->height = h;
        img->channels = c;
        img->data = malloc((size_t)w * h * c * sizeof(float));

        TIFF* tif = TIFFOpen(filename, "r");
        float* scanline = malloc(TIFFScanlineSize(tif));

        for (int y = 0; y < h; y++) {
            TIFFReadScanline(tif, scanline, y, 0);
            for (int x = 0; x < w * c; x++) {
                img->data[y * w * c + x] = scanline[x];
            }
        }

        free(scanline);
        TIFFClose(tif);
    }

    return img;   // Valid only for rank 0, on other ranks img = NULL
}