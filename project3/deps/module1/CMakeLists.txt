# This is a static and dynamic library module, with GLOB for src and headers

cmake_minimum_required(VERSION 3.0)
project(module1 VERSION 1.2.3)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")

# For those favor globbing files in directories
file(GLOB module1_SRCS "src/*.cpp")

# Build
reason_add_library(STATIC SHARED TARGET "module1" INC_DIRS "include" SRCS "${module1_SRCS}")

reason_install(TARGETS "module1_s" "module1_d" INC_DIRS "include")
 
# Test
enable_testing()
reason_add_multiple_tests(TEST_NAME "test_m1" SRCS "test/test1_m1.cpp" "test/test2_m1.cpp" LINKS "module1_d")
