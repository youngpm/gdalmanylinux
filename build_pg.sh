#!/bin/bash

# Build libpq for PG 12
# From https://github.com/psycopg/psycopg2-wheels

POSTGRES_TAG="REL_12_5"
POSTGRES_DIR="postgres-${POSTGRES_TAG}"
if [ -d "${POSTGRES_DIR}" ]; then
    rm -rf "${POSTGRES_DIR}"
fi

curl -f -L -O https://github.com/postgres/postgres/archive/${POSTGRES_TAG}.tar.gz
tar xzf ${POSTGRES_TAG}.tar.gz

cd "${POSTGRES_DIR}"

# Match the default unix socket dir default with what defined on Ubuntu and
# Red Hat, which seems the most common location
sed -i 's|#define DEFAULT_PGSOCKET_DIR .*'\
'|#define DEFAULT_PGSOCKET_DIR "/var/run/postgresql"|' \
    src/include/pg_config_manual.h

./configure --prefix=/usr/local --without-readline \
    --with-gssapi --with-openssl --with-pam --without-ldap
make -j8 -C src/interfaces/libpq
make -j8 -C src/bin/pg_config
make -j8 -C src/include

# Install libpq
make -C src/interfaces/libpq install
make -C src/bin/pg_config install
# This will fail after installing postgres_fe.h, which is the bit we need
make -C src/include install || true
cd ..
