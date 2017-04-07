# This is a static and dynamic library with binary common, list src files manually

cmake_minimum_required(VERSION 3.0)
project(common2 VERSION 2.8.12)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")

set(PROJECT_SRCS "src/c2.cpp")

# Build
reason_add_library(STATIC TARGET "common2" INC_DIRS "include" SRCS "${PROJECT_SRCS}" LINKS common1_s)
reason_add_library(SHARED TARGET "common2" INC_DIRS "include" SRCS "${PROJECT_SRCS}" LINKS common1_d)

# Build executable
reason_add_executable(TARGET "common2_1" SRCS "src/main1.cpp" LINKS "common2_s")
reason_add_executable(TARGET "common2_2" SRCS "src/main2.cpp" LINKS "common2_s")

reason_install(TARGETS "common2_1" "common2_2" "common2_s" "common2_d" INC_DIRS "include")
 
# Test
enable_testing()
reason_add_multiple_tests(TEST_NAME "test_c2" SRCS "test/test1_c2.cpp" "test/test2_c2.cpp" LINKS "common2_d")
