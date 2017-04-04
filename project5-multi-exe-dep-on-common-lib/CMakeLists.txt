cmake_minimum_required(VERSION 3.0)
project(project5 VERSION 1.0.0)

set(CMAKE_INSTALL_PREFIX "${CMAKE_SOURCE_DIR}/install/")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/../reason/")
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/../cotire/CMake/")
set(REASON_VERBOSE TRUE)
set(REASON_BRIEF_PATH TRUE)
include(reason)

message(STATUS "Configure ${PROJECT_NAME} (${PROJECT_VERSION})")
message(STATUS "Install directory: ${CMAKE_INSTALL_PREFIX}")

add_subdirectory("deps/common1")
add_subdirectory("deps/common2")
add_subdirectory("deps/module3")

set(PROJECT_SRCS "src/the_main1.cpp" "src/the_main2.cpp")

reason_add_library(STATIC TARGET "project5" SRCS "${PROJECT_SRCS}"
  INC_DIRS "include" 
  LINKS "common1_s" "common2_s" "module3_s")
reason_add_library(SHARED TARGET "project5" SRCS "${PROJECT_SRCS}"
  INC_DIRS "include" 
  LINKS "common1_d" "common2_d" "module3_d")
reason_add_executable(TARGET "project5_s_exe" SRCS "src/main.cpp" LINKS "project5_s")
reason_add_executable(TARGET "project5_d_exe" SRCS "src/main.cpp" LINKS "project5_d")
reason_install(TARGETS "project5_s" "project5_d" "project5_s_exe" "project5_d_exe" INC_DIRS "include")
 
# Enable testing for testing submodules
reason_add_multiple_tests(TEST_NAME "test_project5" SRCS "test/test1_project5.cpp" LINKS "project5_s")
enable_testing()

set(CPACK_GENERATOR "STGZ;TGZ;TZ")
reason_pack_deb(
  CONTACT  "Firstname Lastname <email@example.com>"
  DESCSUM  "project5 Short Desc"
  DESC     "project5 Long Desc"
  ARCH     "amd64"
  DEBDEP   "libc6 (>= 2.4)"
  SECTION  "devel"
  PRIORITY "optional")
include(CPack)
