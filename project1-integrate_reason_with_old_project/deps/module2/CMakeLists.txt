# module2 does not use reason, it shows how to integreate legacy modules with reason.cmake
# This is a static and dynamic library with binary module, list src files manually

cmake_minimum_required(VERSION 3.0)
project(module2 VERSION 2.8.12)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")

set(TARGET_NAME ${PROJECT_NAME})
set(TARGET_NAME_SLIB ${PROJECT_NAME}_s)
set(TARGET_NAME_DLIB ${PROJECT_NAME}_d)

# Manually list src files and header files
set(PROJECT_HDRS "include/${PROJECT_NAME}/m2.hpp")
set(PROJECT_SRCS "src/m2.cpp")

# Build
add_library(${TARGET_NAME_SLIB} STATIC "${PROJECT_SRCS}")
target_include_directories("${TARGET_NAME_SLIB}"
  PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include> $<INSTALL_INTERFACE:include>)

add_library(${TARGET_NAME_DLIB} SHARED "${PROJECT_SRCS}")
target_include_directories("${TARGET_NAME_DLIB}"
  PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include> $<INSTALL_INTERFACE:include>)

# Link
# Nothing to link to

# Handle RPATH
set_target_properties(${TARGET_NAME_DLIB} PROPERTIES INSTALL_RPATH "$ORIGIN/../lib")
set_target_properties(${TARGET_NAME_DLIB} PROPERTIES INSTALL_RPATH_USE_LINK_PATH TRUE)

# Build executable
add_executable("${TARGET_NAME}_1" src/main1.cpp)
target_include_directories("${TARGET_NAME}_1"
  PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include> $<INSTALL_INTERFACE:include>)
target_link_libraries("${TARGET_NAME}_1" "${TARGET_NAME_SLIB}") # Static Link
set_target_properties("${TARGET_NAME}_1" PROPERTIES INSTALL_RPATH "$ORIGIN/../lib")
set_target_properties("${TARGET_NAME}_1" PROPERTIES INSTALL_RPATH_USE_LINK_PATH TRUE)

add_executable("${TARGET_NAME}_2" src/main2.cpp)
target_include_directories("${TARGET_NAME}_2"
  PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include> $<INSTALL_INTERFACE:include>)
target_link_libraries("${TARGET_NAME}_2" "${TARGET_NAME_DLIB}") # Dynamic Link
set_target_properties("${TARGET_NAME}_2" PROPERTIES INSTALL_RPATH "$ORIGIN/../lib")
set_target_properties("${TARGET_NAME}_2" PROPERTIES INSTALL_RPATH_USE_LINK_PATH TRUE)
 
# Install
install(TARGETS
  "${TARGET_NAME}_1"
  "${TARGET_NAME}_2"
  "${TARGET_NAME_SLIB}"
  "${TARGET_NAME_DLIB}"
  EXPORT "${PROJECT_NAME}Config"
  RUNTIME DESTINATION "bin"
  ARCHIVE DESTINATION "lib"
  LIBRARY DESTINATION "lib")
# install headers file by file, for GLOB @see module1
# install(FILES) does not keep directory structure, so you need to specify
install(FILES ${PROJECT_HDRS} DESTINATION "include/${PROJECT_NAME}/")
# make it an importable project
install(EXPORT "${PROJECT_NAME}Config" DESTINATION share/${PROJECT_NAME}/cmake)
 
# Test
add_executable(test1_m2 test/test1_m2.cpp)
target_link_libraries(test1_m2 ${TARGET_NAME_SLIB})
add_test(test_m2 test1_m2)

add_executable(test2_m2 test/test2_m2.cpp)
target_link_libraries(test2_m2 ${TARGET_NAME_DLIB})
add_test(test_m2 test2_m2)

enable_testing()
