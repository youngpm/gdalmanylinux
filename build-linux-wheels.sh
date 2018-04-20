#!/bin/bash
set -eu

GDAL_BUILD_PATH=/src/gdal-2.2.4/swig/python
ORIGINAL_PATH=$PATH
UNREPAIRED_WHEELS=/tmp/wheels

# Compile wheels
pushd ${GDAL_BUILD_PATH}
for PYBIN in /opt/python/*/bin; do
    if [[ $PYBIN == *"26"* ]]; then continue; fi
    if [[ $PYBIN == *"33"* ]]; then continue; fi
    export PATH=${PYBIN}:$ORIGINAL_PATH
    rm -rf build
    python setup.py bdist_wheel -d ${UNREPAIRED_WHEELS}
done
popd

# Bundle GEOS into the wheels
for whl in ${UNREPAIRED_WHEELS}/*.whl; do
    auditwheel repair ${whl} -w wheels
done
