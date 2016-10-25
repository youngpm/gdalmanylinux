# __init__ for osgeo package.
import os
import sys

# making the osgeo package version the same as the gdal version:
from sys import version_info
if version_info >= (2,6,0):
    def swig_import_helper():
        from os.path import dirname
        import imp
        fp = None
        try:
            fp, pathname, description = imp.find_module('_gdal', [dirname(__file__)])
        except ImportError:
            import _gdal
            return _gdal
        if fp is not None:
            try:
                _mod = imp.load_module('_gdal', fp, pathname, description)
            finally:
                fp.close()
            return _mod
    _gdal = swig_import_helper()
    del swig_import_helper
else:
    import _gdal

__version__ = _gdal.__version__ = _gdal.VersionInfo("RELEASE_NAME")

# Set gdal and proj data directories.
if 'GDAL_DATA' not in os.environ:
    whl_datadir = os.path.abspath(os.path.join(os.path.dirname(__file__), "gdal_data"))
    share_datadir = os.path.join(sys.prefix, 'share/gdal')
    if os.path.exists(os.path.join(whl_datadir, 'pcs.csv')):
        os.environ['GDAL_DATA'] = whl_datadir
    elif os.path.exists(os.path.join(share_datadir, 'pcs.csv')):
        os.environ['GDAL_DATA'] = share_datadir
    if 'PROJ_LIB' not in os.environ:
        whl_datadir = os.path.abspath(os.path.join(os.path.dirname(__file__), "proj_data"))
        os.environ['PROJ_LIB'] = whl_datadir
