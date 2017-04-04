# This is a static and dynamic library common library, with GLOB for src and headers

cmake_minimum_required(VERSION 3.0)
project(common1 VERSION 1.2.3)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")

# For those favor globbing files in directories
file(GLOB common1_SRCS "src/*.cpp")

# Build
reason_add_library(STATIC SHARED TARGET "common1" INC_DIRS "include" SRCS "${common1_SRCS}")

reason_install(TARGETS "common1_s" "common1_d" INC_DIRS "include")
 
# Test
enable_testing()
reason_add_multiple_tests(TEST_NAME "test_c1" SRCS "test/test1_c1.cpp" "test/test2_c1.cpp" LINKS "common1_d")
