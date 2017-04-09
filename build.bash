#!/bin/bash

for project in project*; do
  echo "Building Project: $project"
  cd $project/
  rm -rf build/
  mkdir -p build/
  cd build/
  cmake ../         || exit $?
  make -j$(nproc)   || exit $?
  make test         || exit $?
  make package      || exit $?
  make install      || exit $?
  cd ../
  cd ../
done
