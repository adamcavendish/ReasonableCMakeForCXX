# This is a static and dynamic library with binary module, using reason to simply the whole process

cmake_minimum_required(VERSION 3.0)
project(module3 VERSION 3.6.0)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")

set(PROJECT_SRCS "src/m3.cpp")

# Build
reason_add_library(STATIC SHARED TARGET "module3" INC_DIRS "include" SRCS "${PROJECT_SRCS}")

# Build executable
reason_add_executable(TARGET "module3_1" SRCS "src/main1.cpp" LINKS "module3_s")
reason_add_executable(TARGET "module3_2" SRCS "src/main2.cpp" LINKS "module3_d")

reason_install(TARGETS "module3_1" "module3_2" "module3_s" "module3_d" INC_DIRS "include")
 
# Test
enable_testing()
reason_add_multiple_tests(TEST_NAME "test_m3" SRCS "test/test1_m3.cpp" "test/test2_m3.cpp" LINKS "module3_d" "pthread")
