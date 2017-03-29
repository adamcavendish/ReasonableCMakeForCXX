# This is a static and dynamic library module, with GLOB for src and headers

cmake_minimum_required(VERSION 3.0)
project(module1 VERSION 1.2.3)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")

# For those favor globbing files in directories
file(GLOB module1_HDRS "include/module1/*.hpp")
file(GLOB module1_SRCS "src/*.cpp")

# Build
# Note: target_include_directories vs. include_directories
#   Use 'target_include_directories' help CMake to include corresponding headers
#   when the target is linked against
add_library("module1_s" STATIC "${module1_SRCS}")
target_include_directories("module1_s"
  PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include>" "$<INSTALL_INTERFACE:include>")

add_library("module1_d" SHARED "${module1_SRCS}")
target_include_directories("module1_d"
  PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include>" "$<INSTALL_INTERFACE:include>")

# Link
# Nothing to link to

# Handle RPATH
set_target_properties(module1_d PROPERTIES INSTALL_RPATH "$ORIGIN/../lib")
set_target_properties(module1_d PROPERTIES INSTALL_RPATH_USE_LINK_PATH TRUE)

# Install
install(TARGETS "module1_s" "module1_d" EXPORT "module1Config"
  RUNTIME DESTINATION "bin"
  ARCHIVE DESTINATION "lib"
  LIBRARY DESTINATION "lib")
# For installing file by file, @see module2 for install headers in a dir
# install(FILES) does not keep directory structure, so you need to specify
install(FILES ${module1_HDRS} DESTINATION "include/module1/")
# make it an importable project
install(EXPORT "module1Config" DESTINATION share/module1/cmake)

# Test
add_executable(test1_m1 test/test1_m1.cpp)
target_link_libraries(test1_m1 "module1_s")
add_test(test_m1 test1_m1)

add_executable(test2_m1 test/test2_m1.cpp)
target_link_libraries(test2_m1 "module1_d")
add_test(test_m1 test2_m1)

enable_testing()
