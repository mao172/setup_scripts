#!/bin/sh
# 
#

script_dir=`dirname $0`

service_mode=$1
servers=$2

if [ "${service_mode}" == "" ] ; then
  service_mode=bootstrap
fi

REPO_NAME=cloudconductor_init
GIT_URL=https://github.com/cloudconductor/cloudconductor_init.git

TOOL_DIR=/opt/chefdk/embedded/bin
BUNDLE_TOOL=${TOOL_DIR}/bundle

WORK_DIR=`pwd`
WORK_REPO=init_chefrepo

ls ./${REPO_NAME}
if [ $? -ne 0 ] ; then
  git clone ${GIT_URL}
  cd ${REPO_NAME}/
  git checkout develop
fi

cd ${WORK_DIR}

mkdir ./${WORK_REPO}

if [ ! -f ./${WORK_REPO}/Berksfile ] ; then
  echo "source 'https://supermarket.getchef.com'" >> ./${WORK_REPO}/Berksfile
  echo "" >> ./${WORK_REPO}/Berksfile
  echo "cookbook 'bootstrap', path: '../cloudconductor_init/bootstrap'" >> ./${WORK_REPO}/Berksfile
fi

if [ ! -f ./${WORK_REPO}/Gemfile ] ; then
  cp ./tomcat_cluster_pattern/Gemfile ./${WORK_REPO}/Gemfile
fi

cd ./${WORK_REPO}/

${BUNDLE_TOOL} config build.nokogiri --use-system-libraries
${BUNDLE_TOOL} install
${BUNDLE_TOOL} exec berks vendor cookbooks

mkdir ./roles

echo '{"name":"setup","description":"Setup Role","chef_type":"role","json_class":"Chef::Role","run_list":["consul::install_source","consul::_service"]}' | jq '.' > ./roles/setup.json

echo "{\"consul\":{\"service_mode\":\"${service_mode}\",\"servers\":[\"${servers}\"]},\"run_list\":[\"role[setup]\"]}" | jq '.' > ./dna.json

if [ ! -f ./solo.rb ] ; then
  cp ${script_dir}/files/solo.rb ./solo.rb
fi

chef-solo -c solo.rb -j dna.json
