#!/bin/sh

echo "JOIN_ADDRESS=\"${1}\"" >> /opt/cloudconductor/config

service consul start

cd /opt/cloudconductor

source /opt/cloudconductor/lib/common.sh

export ROLE=${2}

export PATH=${PATH}:`chefdk_path`

echo "ROLE=${ROLE}" >> /opt/cloudconductor/config

source /opt/cloudconductor/config

export CONSUL_SECRET_KEY=${CONSUL_SECRET_KEY}

bash -x /opt/cloudconductor/bin/configure.sh
