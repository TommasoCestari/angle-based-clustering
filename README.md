# Angle-based-clustering

This repository contains an implementation of the Angle-Based Clustering (ABC) algorithm for clustering Sentinel-2 satellite imagery. It includes both a serial C implementation and a distributed-memory parallel implementation using MPI.

## Directory Structure

```text

├─ README.md                  # Project overview (this file)
├─ Makefile                   # Top-level orchestrator for building serial and MPI versions
├─ .env                       # Environment variables (e.g., Sentinel Hub credentials)
├─ job_n_cpu.pbs              # PBS script for scaling MPI jobs across multiple CPUs
├─ data/                      # Input TIFFs, output binaries, CSV results, and final clusters
├─ python/                    # Python scripts for data pipeline
│  ├─ main.py                 # Main entry point to fetch Sentinel-2 imagery
│  ├─ from_vector_to_tiff.py  # Post-processing script to convert binary clusters back to TIFF
│  └─ utils/                  # Helper modules for API requests and geospatial mapping
├─ serial-implementation/     # Serial C implementation
│  ├─ Makefile                # Build rules for the serial version
│  ├─ include/                # Header files for serial algorithms (DBSCAN, KD-Tree, etc.)
│  └─ src/                    # Source code for the serial implementation
└─ mpi-implementation/        # Parallel C implementation using MPI
   ├─ Makefile                # Build rules for the parallel version
   ├─ include/                # Header files adapted for MPI and parallel logic
   └─ src/                    # Source code for parallel clustering and assignment
```

## The Algorithm
Angle-Based Clustering (ABC) is designed to drastically reduce the runtime of traditional clustering methods by performing complex clustering computations on only a small fraction of the data using a three-step process:

1. **Border Point Detection:** Instead of clustering all data points, the algorithm first identifies only the points located at the outer boundaries of the clusters. It evaluates the angles between the vector pointing to the point's nearest-neighbor mean (kNN-mean) and the vectors pointing to its individual neighbors. Points at the edges of a cluster have neighbors concentrated in mostly one direction, making them mathematically distinguishable from inner points. The algorithm sorts the data and extracts only the top percentage of points (e.g., 5% to 20%) to act as the boundary.
2. **Border Point Clustering:** Once the small subset of border points is isolated, the algorithm applies adapted clustering techniques (such as ABC-DBSCAN or ABC-Hierarchical-SL) exclusively to these boundary points. To improve accuracy and prevent merging distinct clusters, it uses a custom "direction-angle modified distance function," penalizing points that are close together in space but have direction vectors pointing away from each other.
3. **Inner Point Assignment:** Finally, the algorithm deals with the vast majority of the data (the filtered "inner" points). Because the borders of the clusters are already established, each inner point is rapidly assigned to the cluster of its closest border point using a 1-Nearest Neighbor (1NN) classification.

## Prerequisites

### Local environment setup 
Before running the workflow, ensure you have the following installed on your system:

**C / High-Performance Computing:**
* A C compiler (`gcc` or `clang`)
* MPI implementation (e.g., OpenMPI)
* `make`

**Python & Data Processing:**
* Python 3.x
* [QGIS](https://qgis.org/) (Recommended for viewing the final output)

**Python Libraries:**
You will need the following libraries. You can install them via pip:
`pip install rasterio numpy sentinelhub python-dotenv`

### HPC Cluster Environment Setup
If you are running this workflow on the cluster, start by loading the necessary modules:
```bash
module purge
module load mpi4py/3.1.4-gompi-2023a
```


## Workflow & Usage

The data pipeline operates in four distinct phases:

#### 1. Data Fetching (If you don't want custome images you can skip this part, since in the data/ folder there is an image ready to be used)

First, retrieve the base Sentinel-2 imagery.

Fill the .env file in the repo with your Sentinel Hub credentials:
```env

SH_CLIENT_ID=your_client_id

SH_CLIENT_SECRET=your_client_secret

SH_BASE_URL=https://sh.dataspace.copernicus.eu

SH_TOKEN_URL=https://identity.dataspace.copernicus.eu/auth/realms/CDSE/protocol/openid-connect/token

```

Run the data fetching script:

`python/main.py`

This script uses the helper modules in python/utils/ to:

* Download the Sentinel-2 imagery for the selected region of interest.
* Compute additional vegetation and water indices.
* Save the resulting multi-band GeoTIFF into the data/ directory.

---

#### 2. Clustering Execution

Run the core ABC clustering algorithm using either the serial or the MPI implementation.

* Serial implementation:
`make serial`

* MPI implementation:
`make mpi`

Both implementations process the input image and produce the clustering result as a .bin file in the data/ folder:

---

#### 3. Format Conversion

The clustering output is stored as a binary vector. To visualize it geographically, convert it back into a GeoTIFF.

Run:

`python python/from_vector_to_tiff.py`

The script outptus 

data/output_clusters.tiff

---

#### 4. Visualization

Open the generated file in QGIS to visualize and explore the generated clusters over the geographic region.

---

## Complete Workflow

```text

Fetch Sentinel-2 imagery

          │
          ▼

python python/main.py

          │
          ▼

     data/input.tiff

          │
          ▼

 make serial / make mpi

          │
          ▼

  data/final_image.bin

          │
          ▼

python python/from_vector_to_tiff.py

          │
          ▼

data/output_clusters.tiff

          │
          ▼

      Open in QGIS

```


