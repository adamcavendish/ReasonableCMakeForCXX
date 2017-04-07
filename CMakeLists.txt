cmake_minimum_required(VERSION 3.3)
project(ReasonableCMakeForCXX VERSION 0.1.0)

set(CMAKE_INSTALL_PREFIX "${CMAKE_SOURCE_DIR}/install/")
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/reason/")
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cotire/CMake/")

add_subdirectory("project1-integrate-reason-with-old-project")
add_subdirectory("project2")
add_subdirectory("project3")
add_subdirectory("project4-interface-libraries")
add_subdirectory("project5-multi-exe-dep-on-common-lib")
