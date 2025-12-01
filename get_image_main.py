from sentinelhub import SHConfig, DownloadFailedException
from dotenv import load_dotenv
import tifffile
from img_fetch_utils import GeoJson_to_bbox, get_aoi_bbox_and_size, all_bands_request, add_bands, save_tensor_as_tiff

# Load credentials
load_dotenv()  
config = SHConfig()

try:
    if not config.sh_client_id or not config.sh_client_secret:
        raise ValueError("Missing SentinelHub credentials in .env or environment variables.")
except Exception as e:
    raise SystemExit(f"[Config Error] {e}")

start_time = "2025-06-13"
end_time = "2025-06-13"

# Convert GeoJson to bbox, get bbox and size
GeoJson = {
    "type":"Polygon",
    "coordinates":[
        [
            [11.113014,46.047705],
            [11.113014,46.072737],
            [11.137733,46.072737],
            [11.137733,46.047705],
            [11.113014,46.047705]
        ]
    ]}

try: 
    bbox = GeoJson_to_bbox(GeoJson)
except Exception as e:
    raise SystemExit(f"[GeoJSON Error] Invalid GeoJSON format: {e}")

try:
    aoi_bbox, aoi_size = get_aoi_bbox_and_size(bbox)
except Exception as e:
    raise SystemExit(f"[BBox Error] Could not compute bbox/size: {e}")

# Build the request
image = all_bands_request(
    aoi_bbox, aoi_size, config, start_time, end_time)

# Add NDVI, NDWI, NDSI
full_tensor = add_bands(image)     # (H, W, 15)

# Save full tensor with rasterio
save_tensor_as_tiff("./sentinel_tensor.tiff", full_tensor, aoi_bbox)

print("Final tensor shape:", full_tensor.shape)

print(f"Dimension : {image.shape}")
print(f"Dimension : {full_tensor.shape}")