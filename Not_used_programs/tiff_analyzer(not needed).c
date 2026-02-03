#include <stdio.h>
#include <stdlib.h>
#include <tiffio.h>
#include <stdint.h> 

// Function to read and print the structural data of a TIFF file
void analyze_tiff_structure(const char *filename) {
    // Open the TIFF file for reading
    TIFF *tif = TIFFOpen(filename, "r");

    if (!tif) {
        fprintf(stderr, "Error: Could not open TIFF file '%s'. Ensure the file exists and LibTIFF is linked correctly.\n", filename);
        return;
    }

    // --- 1. Get Image Dimensions (H and W) ---
    uint32_t image_width, image_length;
    // TIFFTAG_IMAGEWIDTH (W) and TIFFTAG_IMAGELENGTH (H) are mandatory TIFF tags
    TIFFGetField(tif, TIFFTAG_IMAGEWIDTH, &image_width);
    TIFFGetField(tif, TIFFTAG_IMAGELENGTH, &image_length);

    // --- 2. Get Channel Count (C) ---
    uint16_t samples_per_pixel;
    // TIFFTAG_SAMPLESPERPIXEL is the number of bands (C)
    if (!TIFFGetField(tif, TIFFTAG_SAMPLESPERPIXEL, &samples_per_pixel)) {
        samples_per_pixel = 1; // Default to 1 if tag is missing (e.g., grayscale)
    }

    // --- 3. Get Bits Per Sample (Data Type / Bit Depth) ---
    uint16_t bits_per_sample;
    if (!TIFFGetField(tif, TIFFTAG_BITSPERSAMPLE, &bits_per_sample)) {
        bits_per_sample = 8; // Default to 8-bit if tag is missing
    }

    // --- 4. Get Planar Configuration (Interleaving Style) ---
    //uint16 planar_config;
    //if (!TIFFGetField(tif, TIFFTAG_PLANARCONFIG, &planar_config)) {
    //    planar_config = PLANARCONFIG_CONTIG; // Default to chunky
    //}

    // --- 5. Get Sample Format (Integer, Float, etc.) ---
    uint16_t sample_format = SAMPLEFORMAT_UINT; // Default to Unsigned Integer
    TIFFGetField(tif, TIFFTAG_SAMPLEFORMAT, &sample_format);

    // --- Print Results ---
    printf("--- TIFF Image Structure Analysis ---\n");
    printf("Input File: %s\n", filename);
    printf("\n");
    printf("1. Dimensions (H x W): %u x %u\n", image_length, image_width);
    printf("   -> H: %u (Height)\n", image_length);
    printf("   -> W: %u (Width)\n", image_width);
    printf("2. Channels (C): %u (Samples Per Pixel / Bands)\n", samples_per_pixel);

    // Calculate the total number of data elements in the vector
    long total_elements = (long)image_length * image_width * samples_per_pixel;
    printf("   -> Total Vector Elements (H*W*C): %ld\n", total_elements);

    // Determine the storage type
    const char *format_str;
    switch (sample_format) {
        case SAMPLEFORMAT_INT: format_str = "Signed Integer"; break;
        case SAMPLEFORMAT_UINT: format_str = "Unsigned Integer"; break;
        case SAMPLEFORMAT_IEEEFP: format_str = "Floating Point"; break;
        default: format_str = "Other/Unknown"; break;
    }
    printf("3. Bit Depth & Format: %u bits per sample (%s)\n", bits_per_sample, format_str);

    TIFFClose(tif);
}

int main(int argc, char *argv[]) {
    const char *default_path = "data/sentinel_tensor_10m.tiff";
    const char *filename = NULL;

    if (argc == 2) {
        filename = argv[1];
    } else {
        filename = default_path;
        printf("No argument provided. Using default TIFF file: %s\n", filename);
    }

    analyze_tiff_structure(filename);

    return 0;
}