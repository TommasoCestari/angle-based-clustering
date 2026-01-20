import rasterio
import numpy as np

# Paths
original_tiff = "data/sentinel_tensor_10m.tiff"
final_image_bin = "data/starting_image.bin"
output_tiff = "data/output_15bands.tiff"

# Open original TIFF to read metadata
with rasterio.open(original_tiff) as src:
    width = src.width
    height = src.height
    transform = src.transform
    crs = src.crs
    profile = src.profile.copy()

# Load raw binary (float32, interleaved pixels)
final_image = np.fromfile(final_image_bin, dtype=np.float32)

# Reshape to (H, W, C)
final_image = final_image.reshape((height, width, 15))
print("Final image shape (H, W, C):", final_image.shape)

# Convert to Rasterio format: (C, H, W)
final_image = np.transpose(final_image, (2, 0, 1))
print("Final image shape (C, H, W):", final_image.shape)

# Update profile for 15-band float32 TIFF
profile.update(
    dtype=np.float32,
    count=15,
    compress='lzw'
)

# Write the TIFF (write ALL bands at once)
with rasterio.open(output_tiff, 'w', **profile) as dst:
    dst.write(final_image)

print("Output TIFF created:", output_tiff)
