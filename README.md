# GDAL Python Bindings Via *manylinux* Wheels

Since the acceptance of [PEP 513](https://www.python.org/dev/peps/pep-0513/), Python now supports *manylinux* wheels for packing up Python code with the c extensions vendorized into the wheel itself.  

This repo provides a template for building GDAL's python bindings as manylinux wheels, allowing for a quick install of the GDAL Python bindings without expicitly installing GDAL and its dependencies. 

The template was directly derived from the [rasterio](https://github.com/mapbox/rasterio) project, which provides a new (and fantastic) interface to GDAL.  

## Building the Wheels

The building of the wheels is done via the docker container provided by the Python Packaging Authority as described [here](https://github.com/pypa/manylinux).

To build, clone this repo, navigate to its root and run `make wheels`.  The container may take a while to build on first go, but once complete you should have a subdirectory called `wheels` filled with wheels containing the bindings.  

The resulting wheels have the gdal and proj data directories packaged up inside of them, but you can set the appropriate environment viaraibles to use your own data directories. 

## Using the Wheels.

These may be `pip` installed into your linux environment ad nauseam.  For example, from the directory containing the 'wheels' directory, you can run
```
docker run -v `pwd`:/io -it --rm python:2.7 /bin/bash
```
to get yourself into a clean python docker container.  From inside this container, try
```
pip install /io/wheels/GDAL-2.1.3-cp27-cp27mu-manylinux1_x86_64.whl
```
You should experience a quick install of GDAL and Numpy.  Try them out!
