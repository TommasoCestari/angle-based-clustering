from sentinelhub import SHConfig, DownloadFailedException
from dotenv import load_dotenv
from img_fetch import GeoJson_to_bbox, get_aoi_bbox_and_size, all_bands_request

# Load credentials
load_dotenv()  
config = SHConfig()

try:
    if not config.sh_client_id or not config.sh_client_secret:
        raise ValueError("Missing SentinelHub credentials in .env or environment variables.")
except Exception as e:
    raise SystemExit(f"[Config Error] {e}")

start_time = "2024-12-12"
end_time = "2024-12-18"

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
request_all_bands = all_bands_request(
    aoi_bbox, (184, 283), config, start_time, end_time)

# Fetch the data
try:
    image_data = request_all_bands.get_data()
except DownloadFailedException as e:
    raise SystemExit(f"[SentinelHub Error] Download failed: {e}")
except Exception as e:
    raise SystemExit(f"[Unexpected Error] {e}")

print("Image data: ", image_data)