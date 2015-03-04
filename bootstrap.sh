#!/bin/bash -x
#
# ${1} - pattern name ex: tomcat_claster_pattern
# ${2} - role (lb, web, ap, db)
# ${3} - consul acl token

cd /opt
rm -rf ./cloudconductor
git clone https://github.com/cloudconductor/cloudconductor_init.git
mv cloudconductor_init cloudconductor
cd /opt/cloudconductor
git checkout develop

export PATTERN_NAME="${1}"
export PATTERN_URL="https://github.com/cloudconductor-patterns/${1}.git"
export PATTERN_REVISION="develop"
export ROLE="${2}"
export CONSUL_SECRET_KEY="${3}"

printenv

TOOLS_DIR=/opt/chefdk/embedded/bin
BUNDLE_TOOL=${TOOLS_DIR}/bundle

${BUNDLE_TOOL} config build.nokogiri --use-system-libraries
. /opt/cloudconductor/bin/init.sh

script_dir=`dirname $0`
. ${script_dir}/curl_config.sh
. ${script_dir}/consul_webui.sh
