#!/bin/bash
set -e

GDAL_BUILD_PATH=/src/gdal-2.4.0/swig/python
ORIGINAL_PATH=$PATH
UNREPAIRED_WHEELS=/tmp/wheels

# Enable devtoolset-2 for C++11
source /opt/rh/devtoolset-2/enable

# Compile wheels
pushd ${GDAL_BUILD_PATH}
for PYBIN in /opt/python/*/bin; do
    if [[ $PYBIN == *"26"* ]]; then continue; fi
    if [[ $PYBIN == *"33"* ]]; then continue; fi
    if [[ $PYBIN == *"39"* ]]; then continue; fi
    export PATH=${PYBIN}:$ORIGINAL_PATH
    rm -rf build
    CFLAGS="-std=c++11" python setup.py bdist_wheel -d ${UNREPAIRED_WHEELS}
done
popd

# Bundle GEOS into the wheels
for whl in ${UNREPAIRED_WHEELS}/*.whl; do
    auditwheel repair ${whl} -w wheels
done
