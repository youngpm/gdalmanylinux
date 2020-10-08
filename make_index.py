#!/usr/bin/env python

# Original code from https://github.com/girder/large_image_wheels
# Author: David Manthey <david.manthey@kitware.com>
# Licence: Apache Licence 2.0
# Modified by Someware-fr

import os
import sys
import time

path = 'gh-pages' if len(sys.argv) == 1 else sys.argv[1]
indexName = 'index.html'
template = """<html>
<head><title>someGDALware</title></head>
<body>
<h1>someGDALware</h1>
<pre>
%LINKS%
</pre>
</body>
"""
link = '<a href="%s" download="%s">%s</a>%s%s%11d'

wheels = [(name, name) for name in os.listdir(path) if name.endswith('whl')]

wheels = sorted(wheels)
maxnamelen = max(len(name) for name, url in wheels)
index = template.replace('%LINKS%', '\n'.join([
    link % (
        url, name, name, ' ' * (maxnamelen + 3 - len(name)),
        time.strftime('%Y-%m-%d %H:%M:%S', time.gmtime(os.path.getmtime(
            os.path.join(path, name)))),
        os.path.getsize(os.path.join(path, name)),
    ) for name, url in wheels]))
open(os.path.join(path, indexName), 'w').write(index)

