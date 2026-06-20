import rasterio
import numpy as np
import os
from pathlib import Path

# Paths
project_root = Path(__file__).resolve().parents[1]
data_dir = project_root / "data"

original_tiff = data_dir / "sentinel_tensor_original_small.tiff"
final_image_bin = data_dir / "final_image.bin"
output_tiff = data_dir / "output_clusters.tiff"

# Open original TIFF to read metadata
with rasterio.open(original_tiff) as src:
    width = src.width
    height = src.height
    profile = src.profile.copy()

# --- THE DOUBLE CONDITION LOGIC ---
file_size_bytes = os.path.getsize(final_image_bin)
total_pixels = width * height
bytes_per_pixel = file_size_bytes // total_pixels

print(f"File size: {file_size_bytes} bytes | Pixels: {total_pixels} | Bytes/Pixel: {bytes_per_pixel}")

if bytes_per_pixel == 2:
    print("-> Detected OLD SERIAL output (16-bit).")
    numpy_type = np.uint16
    rasterio_type = rasterio.uint16
elif bytes_per_pixel == 4:
    print("-> Detected PARALLEL or NEW SERIAL output (32-bit).")
    numpy_type = np.int32
    rasterio_type = rasterio.int32
else:
    raise ValueError(f"File size error or corrupted file! (Bytes per pixel: {bytes_per_pixel})")

# Load finalImage binary file dynamically
final_image = np.fromfile(final_image_bin, dtype=numpy_type)
final_image = final_image.reshape((height, width))

# Update profile dynamically
profile.update(
    dtype=rasterio_type,
    count=1,
    compress='lzw'  
)

# Write the new TIFF
with rasterio.open(output_tiff, 'w', **profile) as dst:
    dst.write(final_image, 1)

print("Output TIFF created successfully:", output_tiff)