#!/usr/bin/env bash

set -e

cd
cd bb-dir
source sandbox/bin/activate
buildbot-worker start worker
