#!/bin/sh

StartDir=$PWD
Target="$PWD/libchrome"

ChromiumSVNURL=http://src.chromium.org/chrome/trunk/src/
BuildToolsGitURL=https://chromium.googlesource.com/chromium/buildtools
GYPGitURL=https://chromium.googlesource.com/external/gyp
ICUGitURL=https://chromium.googlesource.com/chromium/deps/icu52.git
PsychoGitURL=https://chromium.googlesource.com/chromium/deps/psyco_win32
TestingGitURL=https://chromium.googlesource.com/chromium/testing/gtest

if [ ! -d "$Target/.svn" ]; then
  echo Settings up repository:
  svn checkout --depth empty $ChromiumSVNURL $Target
  cd $Target
  svn update --set-depth empty chrome/
  svn update --set-depth empty third_party/
else
  echo Opening repository
  cd $Target
fi

echo 'Fetching newest Chromium (necessary part):'
svn update --set-depth infinity base/
svn update --set-depth infinity build/
svn update --set-depth empty    chrome/VERSION
svn update --set-depth infinity testing/
svn update --set-depth infinity third_party/android_crazy_linker/
svn update --set-depth infinity third_party/ashmem/
svn update --set-depth infinity third_party/libevent/
svn update --set-depth infinity third_party/libxml/
svn update --set-depth infinity third_party/modp_b64/
svn update --set-depth infinity third_party/zlib/
ChromiumRevision=$(svn info | grep "Revision" | awk '{print $2}')

if [ ! -d buildtools ]; then
  echo 'Fetching buildtools:'
  git clone --depth 1 $BuildToolsGitURL buildtools
fi
BuildToolsRevision=$(git --git-dir=$Target/buildtools/.git rev-parse HEAD)

if [ ! -d testing/gtest ]; then
  echo 'Fetching GTest:'
  git clone --depth 1 $TestingGitURL testing/gtest
fi
GTestRevision=$(git --git-dir=$Target/testing/gtest/.git rev-parse HEAD)

if [ ! -d third_party/icu ]; then
  echo 'Fetching ICU:'
  git clone --depth 1 $ICUGitURL third_party/icu
fi
ICURevision=$(git --git-dir=$Target/third_party/icu/.git rev-parse HEAD)

if [ ! -d third_party/psycho ]; then
  echo 'Fetching Psycho:'
  git clone --depth 1 $PsychoGitURL third_party/psycho
fi
PsychoRevision=$(git --git-dir=$Target/third_party/psycho/.git rev-parse HEAD)

if [ ! -f tools/gyp/gyp ]; then
  echo 'Fetching GYP:'
  git clone --depth 1 $GYPGitURL tools/gyp
fi
GypRevision=$(git --git-dir=$Target/tools/gyp/.git rev-parse HEAD)

echo "Currently fetched sources' revisions (listed for debug purpose):"
echo " - Chromium   : $ChromiumRevision"
echo " - BuildTools : $BuildToolsRevision"
echo " - GTest      : $GTestRevision"
echo " - ICU        : $ICURevision"
echo " - Psycho     : $PsychoRevision"
echo " - Gyp        : $GypRevision"

cd $StartDir
