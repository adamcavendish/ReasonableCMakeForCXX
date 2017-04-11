cmake_minimum_required(VERSION 3.3)
project(project6 VERSION 1.0.0)

set(CMAKE_INSTALL_PREFIX "${CMAKE_SOURCE_DIR}/install/")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/../reason/")
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/../cotire/CMake/")

set(REASON_VERBOSE FALSE)
set(REASON_BRIEF_PATH TRUE)
include(reason)

message(STATUS "Configure ${PROJECT_NAME} (${PROJECT_VERSION})")
message(STATUS "Install directory: ${CMAKE_INSTALL_PREFIX}")

find_package(CUDA REQUIRED)
list(APPEND CUDA_NVCC_FLAGS "-std=c++11 -gencode arch=compute_52,code=sm_52")

# FindCUDA hack
# https://gitlab.kitware.com/cmake/cmake/issues/16602
set(CUDA_LIBRARIES PUBLIC ${CUDA_LIBRARIES})
set(CUDA_cudadevrt_LIBRARY PUBLIC ${CUDA_cudadevrt_LIBRARY})

reason_add_library(MODE cuda STATIC SHARED TARGET "cuda_util" INC_DIRS "include" SRCS "src/cuda_util.cu")
reason_add_executable(MODE cuda TARGET "vec_add_s" SRCS "src/vec_add.cu" LINKS "cuda_util_s")
reason_add_executable(MODE cuda TARGET "vec_add_d" SRCS "src/vec_add.cu" LINKS "cuda_util_d")
