import numpy as np
import rasterio
from rasterio.transform import from_bounds
from sentinelhub import (
    
    SentinelHubRequest,
    bbox_to_dimensions,
    to_utm_bbox,
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


def all_bands_request(utm_bbox: BBox,
                        aoi_size: tuple,
                        config: SHConfig,
                        start_time_single_image: str = "2024-05-01",
                        end_time_single_image: str = "2024-05-20") -> np.ndarray:
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
                        "B08","B8A","B09","B11","B12"]
            }],
            output: {
                bands: 12,
                sampleType: "FLOAT32"
            }
        };
    }

    function evaluatePixel(sample) {
        return [sample.B01, sample.B02, sample.B03, sample.B04, sample.B05,
                sample.B06, sample.B07, sample.B08, sample.B8A, sample.B09,
                sample.B11, sample.B12];
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
        bbox=utm_bbox,
        size=aoi_size,
        config=config,
    )

    # Download the data
    data = request_all_bands.get_data()[0]
    return data


def add_bands(image_data):
    """
    Compute vegetation and water indices (NDVI, NDWI, NDSI) and append them
    as additional bands to a multi-band Sentinel-2 image tensor.

    The input image tensor should have shape (H, W, C) where C >= 12 (Sentinel-2 bands)

    Args:
        image_data (np.ndarray): Input image tensor with shape (H, W, C), dtype float32 or float64.

    Returns:
        np.ndarray: New image tensor with shape (H, W, C+3), where the last three bands
                    are NDVI, NDWI, and NDSI respectively.
    """

    B01 = image_data[..., 0]
    B02 = image_data[..., 1]
    B03 = image_data[..., 2]
    B04 = image_data[..., 3]
    B05 = image_data[..., 4]
    B06 = image_data[..., 5]
    B07 = image_data[..., 6]
    B08 = image_data[..., 7]
    B8A = image_data[..., 8]
    B09 = image_data[..., 9]
    B11 = image_data[..., 10]
    B12 = image_data[..., 11]

    eps = 1e-10
    NDVI = (B08 - B04) / (B08 + B04 + eps)
    NDWI = (B03 - B11) / (B03 + B11 + eps)  # McFeeters version
    NDSI = (B03 - B11) / (B03 + B11 + eps)

    image_with_indices = np.dstack([image_data, NDVI, NDWI, NDSI])
    return image_with_indices


def save_tensor_as_tiff(tensor, aoi_bbox, path):
    """
    Save a multi-band tensor as a GeoTIFF, optionally upsampling to 10m resolution.

    Args:
        tensor (np.ndarray): Input tensor, shape (H, W, C)
        aoi_bbox (BBox): SentinelHub BBox object defining the area
        path (str): Output file path
        scale_factor (int): Upsampling factor; 1 = keep original resolution
    """

    H, W, C = tensor.shape
    tensor = tensor.transpose(2, 0, 1).astype("float32")

    min_x, min_y = aoi_bbox.lower_left
    max_x, max_y = aoi_bbox.upper_right
    transform = from_bounds(min_x, min_y, max_x, max_y, W, H)

    rasterio_crs = f"EPSG:{aoi_bbox.crs.ogc_string().split(':')[-1]}"

    # Save GeoTIFF
    with rasterio.open(
        path,
        "w",
        driver="GTiff",
        height=H,
        width=W,
        count=C,
        dtype="float32",
        crs=rasterio_crs,
        transform=transform
    ) as dst:
        dst.write(tensor)

    print(f"Saved stacked tensor TIFF to {path} (shape: {C} bands, {H}x{W})")