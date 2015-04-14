#!/bin/sh
if [ ! $DepotToolsPython ]; then
  DepotToolsPython=python
fi

Target=libchrome
cd $Target

echo Building VS solution:
$DepotToolsPython build/gyp_chromium --depth=. --root-target=base
ninja -C out/Release base
ninja -C out/Debug base
