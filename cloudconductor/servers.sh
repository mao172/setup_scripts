#!/bin/sh

hostname=`hostname`
key=cloudconductor/servers/${hostname}

echo "key=${key}"

func_set() {
  roles=$1

  ip_addr=`hostname -i`

  json="{\"roles\":\"${roles}\",\"private_ip\":\"${ip_addr}\"}"

  echo ${json}

  curl -XPUT -d ${json} http://localhost:8500/v1/kv/${key}

}

func_remove() {
  curl -XDELETE http://localhost:8500/v1/kv/${key}
}

case $1 in
  set) func_set $2 ;;
  remove) func_remove ;;
esac

curl -s http://localhost:8500/v1/kv/${key} | jq '.[].Value | .' -r | base64 -d | jq '.'
