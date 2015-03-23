#!/bin/bash -x

GEM_NAME=cloud_conductor_utils
GIT_URL=https://github.com/cloudconductor/cloud_conductor_utils.git

TOOLS_DIR=/opt/chefdk/embedded/bin
GEM_TOOL=${TOOLS_DIR}/gem
RAKE_TOOL=${TOOLS_DIR}/rake

WORK_DIR=`pwd`

# export PATH=/opt/chefdk/embedded/bin:$PATH
cd ${WORK_DIR}

${GEM_TOOL} list | grep ${GEM_NAME}
if [ $? -eq 0 ] ; then
  exit
fi


ls ./${GEM_NAME}
if [ $? -ne 0 ] ; then
  git clone ${GIT_URL}
fi

cd ${GEM_NAME}/
git checkout develop

${RAKE_TOOL} build
${GEM_TOOL} install pkg/${GEM_NAME}-0.0.1.gem
${GEM_TOOL} list | grep ${GEM_NAME}

