#!/bin/bash -x
#
# ${1} - pattern name ex: tomcat_claster_pattern
# ${2} - role (lb, web, ap, db)
# ${3} - consul acl token

if [ "$1" == "" ] ; then
  echo -n "PATTERN NAME > "
  read in_pattern
else
  in_pattern=$1
fi

if [ "$2" == "" ] ; then
  echo -n "ROLE > "
  read in_role
else
  in_role=$2
fi

if [ "$3" == "" ] ; then
  echo -n "ACL TOKEN > "
  read in_token
else
  in_token=$3
fi

cd /opt
rm -rf ./cloudconductor
git clone https://github.com/cloudconductor/cloudconductor_init.git
mv cloudconductor_init cloudconductor
cd /opt/cloudconductor
git checkout -b deploy 5ca0ae2f80e94f017bab8370190aca19e95cab08

export PATTERN_NAME="${in_pattern}"
export PATTERN_URL="https://github.com/cloudconductor-patterns/${in_pattern}.git"
export PATTERN_REVISION="develop"
export ROLE="${in_role}"
export CONSUL_SECRET_KEY="${in_token}"

printenv

TOOLS_DIR=/opt/chefdk/embedded/bin
BUNDLE_TOOL=${TOOLS_DIR}/bundle

${BUNDLE_TOOL} config build.nokogiri --use-system-libraries
. /opt/cloudconductor/bin/init.sh

script_dir=`dirname $0`
. ${script_dir}/curl_config.sh
. ${script_dir}/consul_webui.sh
