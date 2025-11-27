from sentinelhub import (
    
    SentinelHubRequest,
    bbox_to_dimensions,
    DataCollection,
    SHConfig,
    MimeType,
    BBox,
    CRS,
    
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
    Converts a bounding box in WGS84 format into a SentinelHub-compatible BBox object
    and computes the corresponding image size in pixels at the given spatial resolution.

    This function is typically used to prepare an area of interest (AOI) for a SentinelHub
    request by wrapping the bounding box and computing the width and height (in pixels)
    based on the desired resolution in meters.

    Args:
        bbox (list or tuple): A list or tuple in the format [min_long, min_lat, max_long, max_lat].
        resolution (int, optional): Spatial resolution in meters per pixel. Default is 10.

    Returns:
        tuple:
            - BBox: A SentinelHub BBox object in CRS.WGS84 format.
            - tuple: Image size as (width, height) in pixels.
    """
    aoi_bbox = BBox(bbox=bbox, crs=CRS.WGS84)
    aoi_size = bbox_to_dimensions(aoi_bbox, resolution=resolution)

    return aoi_bbox, aoi_size


def all_bands_request(aoi_bbox: BBox,
                        aoi_size: tuple,
                        config: SHConfig,
                        start_time_single_image: str = "2024-05-01",
                        end_time_single_image: str = "2024-05-20") -> SentinelHubRequest:
    """
    Creates a SentinelHubRequest object to retrieve a true color satellite image
    from the Sentinel-2 Level-2A data collection for a given area of interest (AOI)
    and time interval.

    This function builds a request using an evalscript that combines the red (B04),
    green (B03), and blue (B02) bands to produce a true color image, and sets up
    the appropriate parameters for resolution, time, and mosaicking strategy.

    Args:
        aoi_bbox (BBox): A SentinelHub BBox object defining the area of interest in WGS84.
        aoi_size (tuple): Image size as (width, height) in pixels, typically computed from resolution.
        config (SHConfig): Configuration object with SentinelHub credentials and settings.
        start_time_single_image (str): Start date of the time interval (format 'YYYY-MM-DD').
        end_time_single_image (str): End date of the time interval (format 'YYYY-MM-DD').

    Returns:
        SentinelHubRequest: A request object ready to be executed with `.get_data()` to fetch the image.
    """
    evalscript_true_color = """
    //VERSION=3

    function setup() {
        return {
            input: [{
                bands: ["B01","B02","B03","B04","B05","B06","B07",
                        "B08","B8A","B09","B11","B12",
                        "SCL"]
            }],
            output: {
                bands: 13
            }
        };
    }

    function evaluatePixel(sample) {
        return [sample.B01, sample.B02, sample.B03, sample.B04, sample.B05,
                sample.B06, sample.B07, sample.B08, sample.B8A, sample.B09,
                sample.B11, sample.B12, sample.SCL];
    }
    """

    request_all_bands = SentinelHubRequest(
        evalscript=evalscript_true_color,
        input_data=[
            SentinelHubRequest.input_data(
                data_collection=DataCollection.SENTINEL2_L2A.define_from(
                    name="s2l2a", service_url="https://sh.dataspace.copernicus.eu"
                ),
                time_interval=(start_time_single_image, end_time_single_image),
                other_args={"dataFilter": {"mosaickingOrder": "leastCC"}},
            )
        ],
        responses=[SentinelHubRequest.output_response("default", MimeType.TIFF)],
        bbox=aoi_bbox,
        size=aoi_size,
        config=config,
    )

    return request_all_bands