#!/usr/bin/env bash

set -e

if [[ -z $SECRETS ]]; then
  SECRETS="$HOME/secrets"
fi

if [[ ! -e "$SECRETS" ]]; then
  echo "Couldn't find a secrets dir!"
  exit 1
fi

cd
cd bb-dir
source sandbox/bin/activate
buildbot start master
