#!/bin/sh
DepotToolsURL='https://chromium.googlesource.com/chromium/tools/depot_tools.git'
DepotToolsDir="$PWD/depot_tools"

if [ ! -d "$DepotToolsDir/.git" ]; then
  git clone $DepotToolsURL $DepotToolsDir
fi
