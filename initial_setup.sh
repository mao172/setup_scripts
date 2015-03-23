#!/bin/bash -x

script_dir=`dirname $0`

yum install -y yum-plugin-priorities
yum install -y rsyslog

${script_dir}/ccu_gem_install.sh
${script_dir}/git_config.sh
${script_dir}/curl_config.sh

EPEL_RPM=http://ftp-srv2.kddilabs.jp/Linux/distributions/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm

yum install -y ${EPEL_RPM}

yum install -y jq

yum install -y hping3

#${script_dir}/consul_service.sh

gem install serverspec
