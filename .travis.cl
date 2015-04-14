language:       cpp
compiler:       clang
os:
              - linux
              - osx
sudo:           required
before_install:
              - ./fetch_sources.sh
install:
              - sudo sh -c "echo 'deb http://llvm.org/apt/precise/ llvm-toolchain-precise-3.5 main' >> /etc/apt/sources.list"
              - wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key | sudo apt-key add -
              - sudo apt-get update
              - sudo apt-get install clang-3.5
              - export CC=clang-3.5
              - export CXX=clang++-3.5
              - ./fetch_depot_tools.sh
              - export PATH=$PATH:$PWD/depot_tools
script:         ./build_libchrome.sh
notification:
  email:
    on_success: never
    on_failure: never
