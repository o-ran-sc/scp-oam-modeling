#!/bin/bash
################################################################################
#
# Copyright 2020 highstreet technologies GmbH and others
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

################################################################################
# Script linting 3GPP yang modules

# globals
args=("$@")
   VERSION=0.1
       DIR=${args[$# - 1]}
    IMPORT="${DIR}/external-yams"
    TARGET=./target
_3GPP_REPO=https://forge.etsi.org/rep/3GPP/SA5/data-models
 _3GPP_DIR=yang-models

# functions
function show-help {
  echo "Usage: yang-linter [options] <directory>"
  echo 
  echo "As much as possible automatic yang linter"
  echo 
  echo "Options"
  echo "  -3, --3gpp            Clone and lint 3GPP SA5 yang modules and exit"
  echo "  -h, --help            Show this help message and exit"
  echo
  echo "  -i=IMPORTDIR, --imports=IMPORTDiR"
  echo "                        Defines an import directory for standard yang modules"
  echo
  echo "  -s, --status          Show app status information and exit"
  echo
  echo "  -t=TARGETDIR, --target=TARGETDIR"
  echo "                        Defines the target output directory"
  echo
  echo "  -v, --version         Show version number and exit"
  echo 
  echo "  <directory>           The folder containng yang modules"
  quit
}

function clone-3gpp {
  message " INFO | Clone from $_3GPP_REPO"
  # rm -rf ./_3GPP
  # git clone "$_3GPP_REPO" "./_3GPP" 
  DIR="./_3GPP"/"$_3GPP_DIR"
  IMPORT="${DIR}/external-yams"
}

function lint () {
  FNAME="$(basename ${@})"
  echo " INFO | Linting ... ($FNAME)"

  # pyang --strict --path "${IMPORT}" --path "${DIR}" $@
  pyang --format yang --yang-canonical --yang-remove-unused-imports --output "${TARGET}/${FNAME}" --path "${IMPORT}" --path "${DIR}" $@
}

function message () {
  echo >&2 "$@"
}

function error-message () {
  message "ERROR | $@"
  show-help
  quit
}

function show-status {
  PYANG="$(pyang --version)"
  GIT="$(git --version)"
  if [[ $PYANG == pyang* ]] && [[ $GIT == git* ]]
  then
    echo "Status: OK "
    echo "        - ${PYANG}"
    echo "        - ${GIT}"
  else
    echo "Status: Please install latest pyang and git"
    echo "        - https://github.com/mbj4668/pyang"
    echo "        - sudo apt install git-all"
  fi
  quit
}

function show-version {
  echo "yang-linter $VERSION"
  quit
}

function quit {
  exit 1
}


# app
[[ "$#" != "0" ]] || error-message "1 argument required, $# provided"

for i in "$@"
do
case $i in
    -3|--3gpp)
    clone-3gpp
    ;;
    -h|--help)
    show-help
    ;;
    -s|--status)
    show-status
    ;;
    -t=*|--target=*)
    TARGET="${i#*=}"
    ;;
    -v|--version)
    show-version
    ;;
    *)
      # message " WARN | Unknown option: $i"
    ;;
esac
done

[[ -d "$DIR" ]] || error-message "Directory '$DIR' does not exist"

echo    DIR = ${DIR}
echo TARGET = ${TARGET}
rm -rf ${TARGET}
mkdir ${TARGET}

for yang in ${DIR}/*.yang
do
    [ -f "$yang" ] || break
    lint ${yang}
done

echo
quit

# dont change blow
sequence=""
for key in "${!mapping[@]}"
do
  sequence="$sequence s!@$key@!${mapping[$key]}!g; "
done
body=http-post-body.xml
sed -e "$sequence" http-post-body.template.xml > $body;

uri=$protocol://$controller:$port/$path/node/$nodeId/yang-ext:mount/ietf-netconf:get

body=http-post-body.xml
sed -e "$sequence" http-post-body.template.xml > $body;

curl -i -k -u $basicAuth -H $content -H $accept -X POST -d @${body} $uri 

echo
