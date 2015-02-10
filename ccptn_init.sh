#!/bin/sh

yum install -y libxslt-devel

PTN_NAME=tomcat_cluster_pattern
GIT_URL=https://github.com/cloudconductor-patterns/tomcat_cluster_pattern.git

TOOLS_DIR=/opt/chefdk/embedded/bin

BUNDLE_TOOL=${TOOLS_DIR}/bundle

WORK_DIR=`pwd`

cd ${WORK_DIR}

ls ./${PTN_NAME}
if [ $? -ne 0 ] ; then
  git clone ${GIT_URL}
  cd ${PTN_NAME}/
  git checkout develop
fi

cd ${WORK_DIR}/${PTN_NAME}/

${BUNDLE_TOOL} config build.nokogiri --use-system-libraries
${BUNDLE_TOOL} install
