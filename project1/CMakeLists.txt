cmake_minimum_required(VERSION 3.0)
project(project1 VERSION 1.0.0)

set(CMAKE_INSTALL_PREFIX "${CMAKE_SOURCE_DIR}/install/")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/../reason/")
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/../cotire/CMake/")
include(reason)

message(STATUS "Configure ${PROJECT_NAME} (${PROJECT_VERSION})")
message(STATUS "Install directory: ${CMAKE_INSTALL_PREFIX}")

add_subdirectory("dependencies/module1")
add_subdirectory("dependencies/module2")
add_subdirectory("dependencies/module3")

set(PROJECT_SRCS "src/the_main1.cpp" "src/the_main2.cpp")

reason_add_library(TARGET "project1" INC_DIRS "include" SRCS "${PROJECT_SRCS}" LINKS "module1_d" "module2_d" "module3_d")
reason_add_executable(TARGET "project1" SRCS "src/main.cpp" LINKS "project1_s")
reason_install(TARGETS "project1" "project1_s" "project1_d" INC_DIRS "include")
 
# Enable testing for testing submodules
reason_add_multiple_tests(TEST_NAME "test_project1" SRCS "test/test1_project1.cpp" LINKS "project1_s")
enable_testing()

set(CPACK_GENERATOR "STGZ;TGZ;TZ")
reason_pack_deb(
  CONTACT  "Firstname Lastname <email@example.com>"
  DESCSUM  "Project1 Short Desc"
  DESC     "Project1 Long Desc"
  ARCH     "amd64"
  DEBDEP   "libc6 (>= 2.4)"
  SECTION  "devel"
  PRIORITY "optional")
include(CPack)
