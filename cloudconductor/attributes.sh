#!/bin/sh

script_dir=`dirname $0`

if [ "$1" = "" ] ; then 
  json_file=$script_dir/attributes.json
else
  json_file=$1
fi

json=`cat $json_file | jq '.' -c`
curl --noproxy localhost -XPUT -d "$json" http://localhost:8500/v1/kv/cloudconductor/parameters

curl -s http://localhost:8500/v1/kv/cloudconductor/parameters | jq '.[].Value | .' -r | base64 -d | jq '.'
