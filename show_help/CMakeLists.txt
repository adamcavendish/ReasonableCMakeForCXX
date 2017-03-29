cmake_minimum_required(VERSION 3.0)
project(help VERSION 1.0.0)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/../cmake/")

# reason helps stops the whole configure process,
# and therefore enable only one help (comment others) to see effect.
reason_add_library(HELP)
reason_add_executable(HELP)
reason_install(HELP)
reason_add_multiple_tests(HELP)
reason_pack_deb(HELP)
