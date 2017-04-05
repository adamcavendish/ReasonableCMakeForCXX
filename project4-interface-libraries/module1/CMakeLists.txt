cmake_minimum_required(VERSION 3.3)
project(module1 VERSION 0.1.0)

reason_add_interface_library(TARGET "module1" INC_DIRS "include")
reason_install(TARGETS "module1" INC_DIRS "include")
