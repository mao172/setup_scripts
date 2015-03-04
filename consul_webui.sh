#!/bin/sh

WEBUI_DIR=/opt/consul/webui/
mkdir ${WEBUI_DIR}

cd ${WEBUI_DIR}

wget https://dl.bintray.com/mitchellh/consul/0.5.0_web_ui.zip

unzip 0.5.0_web_ui.zip

echo "{\"ui_dir\":\"/opt/consul/webui\"}" > /etc/consul.d/web_ui.json

#service consul stop

#service consul start

#curl http://localhost:8500/ui/
