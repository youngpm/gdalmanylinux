# GDAL python bindings make file.

SHELL = /bin/bash

wheels: Dockerfile.wheels build-linux-wheels.sh
	docker build -f Dockerfile.wheels -t gdal-wheelbuilder .
	docker run -v `pwd`:/io gdal-wheelbuilder
