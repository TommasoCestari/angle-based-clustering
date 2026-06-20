import rasterio
import numpy as np
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

numpy_type = np.int32
rasterio_type = rasterio.int32

# Load finalImage binary file
final_image = np.fromfile(final_image_bin, dtype=numpy_type)
final_image = final_image.reshape((height, width))

# Update profile
profile.update(
    dtype=rasterio_type,
    count=1,
    compress='lzw'  
)

# Write the new TIFF
with rasterio.open(output_tiff, 'w', **profile) as dst:
    dst.write(final_image, 1)

print("Output TIFF created successfully:", output_tiff)