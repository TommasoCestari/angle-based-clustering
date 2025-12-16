from sentinelhub import (
    bbox_to_dimensions,
    to_utm_bbox,
    BBox,
    CRS    
)

def GeoJson_to_bbox(GeoJson: dict) -> list:
    """
    Convert a GeoJSON Polygon into a bounding box list for SentinelHub.
    Args:
        GeoJson (dict): GeoJSON polygon object
    Returns:
        list: [min_lon, min_lat, max_lon, max_lat]
    """
    coord_list = GeoJson["coordinates"]
    all_lon = [lon for lon, lat in coord_list[0]]
    all_lat = [lat for lon, lat in coord_list[0]]
    min_lon = min(all_lon)
    max_lon = max(all_lon)
    min_lat = min(all_lat)
    max_lat = max(all_lat)
    return [min_lon, min_lat, max_lon, max_lat]


def get_aoi_bbox_and_size(bbox: list, resolution: int = 10) -> tuple:
    """
    Converts a bounding box in WGS84 format into a UTM BBox,
    compute image size in pixels at the given spatial resolution.

    Args:
        bbox (list or tuple): [min_lon, min_lat, max_lon, max_lat]
        resolution (int, optional): Spatial resolution in meters per pixel. Default is 10.

    Returns:
        tuple:
            - BBox: SentinelHub BBox in UTM CRS
            - tuple: Image size as (width, height)
    """
    # WGS84 BBox
    aoi_bbox_wgs84 = BBox(bbox=bbox, crs=CRS.WGS84)

    # transform to UTM automatically
    utm_bbox = to_utm_bbox(aoi_bbox_wgs84)

    # compute size in pixels at 10m resolution
    aoi_size = bbox_to_dimensions(utm_bbox, resolution=resolution)

    return utm_bbox, aoi_size