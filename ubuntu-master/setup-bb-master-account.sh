#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.."

source "$SCRIPT_DIR/bash_fns/detect_os.sh"
source "$SCRIPT_DIR/bash_fns/mkuser.sh"

UNIX_UN=`jq --raw-output '.["unix_un"]' ~/secrets/master_unix_secrets.json`
UNIX_PW=`jq --raw-output '.["unix_pw"]' ~/secrets/master_unix_secrets.json`

if [[ -z $UNIX_UN || -z $UNIX_PW ]]; then
  echo "Trouble reading master username and password from ~/secrets/master_unix_secrets.json"
  exit 1
fi

mkuser "$UNIX_UN" "$UNIX_PW"
