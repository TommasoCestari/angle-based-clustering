from sentinelhub import SHConfig, DownloadFailedException
from dotenv import load_dotenv
from utils.img_fetch import all_bands_request, add_bands, save_tensor_as_tiff
from utils.geospatial import GeoJson_to_bbox, get_aoi_bbox_and_size

def main():
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
        utm_bbox, aoi_size = get_aoi_bbox_and_size(bbox)
    except Exception as e:
        raise SystemExit(f"[BBox Error] Could not compute bbox/size: {e}")

    # Build the request
    try:
        image = all_bands_request(
            utm_bbox, aoi_size, config, start_time, end_time)
    except DownloadFailedException as e:
        raise SystemExit(f"[Download Error]: Could not fetch image: {e}")


    # Add NDVI, NDWI, NDSI
    full_tensor = add_bands(image)     # (H, W, 15)

    # Save full tensor with rasterio
    save_tensor_as_tiff(full_tensor, utm_bbox, "../data/sentinel_tensor_10m.tiff")

    print("Final tensor shape:", full_tensor.shape)

    print(f"Dimension : {image.shape}")
    print(f"Dimension : {full_tensor.shape}")

if __name__ == "__main__":
    main()