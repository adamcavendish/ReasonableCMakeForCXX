#!/bin/bash

for project in project*; do
  cd $project/
  rm -rf build/
  mkdir -p build/
  cd build/
  cmake ../
  make -j$(nproc)
  make test
  make package
  make install
  cd ../
done
