cmake_minimum_required(VERSION 3.3)
project(project4 VERSION 1.0.0)

set(CMAKE_INSTALL_PREFIX "${CMAKE_SOURCE_DIR}/install/")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/../reason/")
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/../cotire/CMake/")

set(REASON_VERBOSE FALSE)
set(REASON_BRIEF_PATH FALSE)
include(reason)

message(STATUS "Configure ${PROJECT_NAME} (${PROJECT_VERSION})")
message(STATUS "Install directory: ${CMAKE_INSTALL_PREFIX}")

add_subdirectory("module1")

reason_add_executable(TARGET "project4" SRCS "src/main.cpp" LINKS "module1")
reason_install(TARGETS "project4")

enable_testing()

reason_pack_deb(
  CONTACT  "Firstname Lastname <email@example.com>"
  DESCSUM  "Project4 Short Desc"
  DESC     "Project4 Long Desc"
  ARCH     "amd64"
  DEBDEP   "libc6 (>= 2.4)"
  SECTION  "devel"
  PRIORITY "optional")
include(CPack)
