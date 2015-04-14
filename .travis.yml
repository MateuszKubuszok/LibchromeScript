language:       cpp
compiler:       clang
os:
              - linux
              - osx
before_install:
              - ./fetch_sources.sh
install:
              - ./fetch_depot_tools.sh
              - export PATH=$PATH:$PWD/depot_tools
script:         ./build_libchrome.sh
notification:
  email:
    on_success: never
    on_failure: never
