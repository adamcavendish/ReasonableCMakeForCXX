# This is a static and dynamic library with binary module, list src files manually

cmake_minimum_required(VERSION 3.0)
project(module2 VERSION 2.8.12)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")

set(PROJECT_SRCS "src/m2.cpp")

# Build
reason_add_library(TARGET "module2" INC_DIRS "include" SRCS "${PROJECT_SRCS}")

# Build executable
reason_add_executable(TARGET "module2_1" SRCS "src/main1.cpp" LINKS "module2_s")
reason_add_executable(TARGET "module2_2" SRCS "src/main2.cpp" LINKS "module2_d")

reason_install(TARGETS "module2_1" "module2_2" "module2_s" "module2_d" INC_DIRS "include")
 
# Test
enable_testing()
reason_add_multiple_tests(TEST_NAME "test_m2" SRCS "test/test1_m2.cpp" "test/test2_m2.cpp" LINKS "module2_d")
