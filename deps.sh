#!/bin/env bash

set -euo pipefail

echo "Download linuxdeploy"
wget -O linuxdeploy https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage

echo "Make executable"
chmod +x linuxdeploy
