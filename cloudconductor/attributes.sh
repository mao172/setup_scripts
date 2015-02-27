#!/bin/sh

source /opt/cloudconductor/config
export PATH=${PATH}:/opt/chefdk/embedded/bin
CONSUL_SECRET_KEY_ENCODED=`ruby -e "require 'cgi'; puts CGI::escape('${CONSUL_SECRET_KEY}')"`


script_dir=`dirname $0`

if [ "$1" = "" ] ; then 
  json_file=$script_dir/attributes.json
else
  json_file=$1
fi

json=`cat $json_file | jq '.' -c`
curl --noproxy localhost -XPUT -d "$json" http://localhost:8500/v1/kv/cloudconductor/parameters?token=${CONSUL_SECRET_KEY_ENCODED}

curl -s http://localhost:8500/v1/kv/cloudconductor/parameters?token=${CONSUL_SECRET_KEY_ENCODED} | jq '.[].Value | .' -r | base64 -d | jq '.'

data=`cat /shared/ssl/server.pem`
curl --noproxy localhost -XPUT http://localhost:8500/v1/kv/ssl_pem?token=${CONSUL_SECRET_KEY_ENCODED} --data-binary "${data}"

curl -s http://localhost:8500/v1/kv/ssl_pem?raw\&token=${CONSUL_SECRET_KEY_ENCODED}
