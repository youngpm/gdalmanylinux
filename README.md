# GDAL Python Bindings Via *manylinux* Wheels

Since the acceptance of [PEP 513](https://www.python.org/dev/peps/pep-0513/), Python now supports *manylinux* wheels for packing up Python code with the c extensions vendorized into the wheel itself.  

This repo provides a template for building GDAL's python bindings as manylinux wheels, allowing for a quick install of the GDAL Python bindings without expicitly installing GDAL and its dependencies. 

The template was directly derived from the [rasterio](https://github.com/mapbox/rasterio) project, which provides a new (and fantastic) interface to GDAL.  

## Building the Wheels

The building of the wheels is done via the docker container provided by the Python Packaging Authority as described [here](https://github.com/pypa/manylinux).

To build, clone this repo, navigate to its root and run `make wheels`.  The container may take a while to build on first go, but once complete you should have a subdirectory called `wheels` filled with wheels containing the bindings.  These may be `pip` installed into your linux environment ad nauseam.  
