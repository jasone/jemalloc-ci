#!/usr/bin/env bash

set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ -z $SECRETS ]]; then
  SECRETS="$HOME/secrets"
fi

if [[ -z $WORKER_BB_SECRETS_FILE ]]; then
  echo "Need WORKER_BB_SECRETS_FILE=/path/to/[ubuntu|freebsd]_bb_secrets.json defined!"
  exit 1
fi

FILENAME="$SECRETS/$WORKER_BB_SECRETS_FILE"

BB_UN=`jq --raw-output '.["bb_un"]' "$SECRETS/$WORKER_BB_SECRETS_FILE"`
BB_PW=`jq --raw-output '.["bb_pw"]' "$SECRETS/$WORKER_BB_SECRETS_FILE"`

MASTER_HOST=`jq --raw-output '.["master_host"]' "$SECRETS/public.json"`

if [[ -z $MASTER_HOST || -z $BB_UN || -z $BB_PW ]]; then
  echo "Trouble obtaining secrets"
  exit 1
fi

cd
if [[ -e bb-dir ]]; then
  rm -r bb-dir
fi

mkdir bb-dir
cd bb-dir
virtualenv --no-site-packages sandbox
source sandbox/bin/activate
pip install buildbot-worker
buildbot-worker create-worker worker $MASTER_HOST $BB_UN $BB_PW
