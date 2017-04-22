cmake_minimum_required(VERSION 3.3)
project(project7 VERSION 1.0.0)

set(CMAKE_INSTALL_PREFIX "${CMAKE_SOURCE_DIR}/install/")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/../reason/")
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/../cotire/CMake/")

set(REASON_VERBOSE FALSE)
set(REASON_BRIEF_PATH FALSE)
include(reason)

message(STATUS "Configure ${PROJECT_NAME} (${PROJECT_VERSION})")
message(STATUS "Install directory: ${CMAKE_INSTALL_PREFIX}")

find_package(glfw3 REQUIRED)

reason_add_library(
  STATIC SHARED
  TARGET "gl3w"
  INC_DIRS "gl3w/include"
  SRCS "gl3w/src/gl3w.c")

reason_add_library(
  STATIC SHARED
  TARGET "imgui"
  INC_DIRS "imgui/include"
  SRCS "imgui/src/imgui.cpp" "imgui/src/imgui_demo.cpp" "imgui/src/imgui_draw.cpp")

set(PROJECT_SRCS "src/imgui_impl_glfw_gl3.cpp")
reason_add_library(
  STATIC
  TARGET "project7"
  INC_DIRS "include" "${glfw3_INCLUDE_DIRS}"
  SRCS "${PROJECT_SRCS}"
  LINKS gl3w_s imgui_s glfw X11 Xrandr Xinerama Xcursor dl pthread)
reason_add_library(
  SHARED
  TARGET "project7"
  INC_DIRS "include" "${glfw3_INCLUDE_DIRS}"
  SRCS "${PROJECT_SRCS}"
  LINKS gl3w_d imgui_d glfw X11 Xrandr Xinerama Xcursor dl pthread)
reason_add_executable(TARGET "project7" SRCS "src/main.cpp" LINKS "project7_s")
reason_install(TARGETS "project7" "project7_s" "project7_d" "gl3w_s" "gl3w_d" "imgui_s" "imgui_d" INC_DIRS "include")

set(CPACK_GENERATOR "STGZ;TGZ;TZ")
reason_pack_deb(
  CONTACT  "Firstname Lastname <email@example.com>"
  DESCSUM  "project7 Short Desc"
  DESC     "project7 Long Desc"
  ARCH     "amd64"
  DEBDEP   "libc6 (>= 2.4)"
  SECTION  "devel"
  PRIORITY "optional")
include(CPack)
