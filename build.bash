#!/bin/bash

CI_PROJECTS=(
  project1-integrate_reason_with_old_project
  project2-depend_on_other_reason_project
  project3-rewrite_project1_with_reason
  project4-header_only_library
  project5-multi_exe_dep_on_common_lib
  # project6-cuda_example                    # Travis: no CUDA support
  project7-glfw_example
)

for project in ${CI_PROJECTS[*]}; do
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
