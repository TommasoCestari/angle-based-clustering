import rasterio
import numpy as np

# Paths
original_tiff = "data/sentinel_tensor_10m.tiff"
final_image_bin = "data/final_image.bin"
output_tiff = "data/output_clusters.tiff"

# Open original TIFF to read metadata
with rasterio.open(original_tiff) as src:
    width = src.width
    height = src.height
    transform = src.transform
    crs = src.crs
    dtype = np.uint16  
    profile = src.profile.copy()

# Load finalImage binary file
final_image = np.fromfile(final_image_bin, dtype=np.uint16)
final_image = final_image.reshape((height, width))
print("Final image shape: ", final_image.shape)
print("Original shape: ", original_tiff)
# Update profile for 1-band, uint16
profile.update(
    dtype=dtype,
    count=1,
    compress='lzw'  
)

# Write the new TIFF
with rasterio.open(output_tiff, 'w', **profile) as dst:
    dst.write(final_image, 1)

print("Output TIFF created:", output_tiff)
