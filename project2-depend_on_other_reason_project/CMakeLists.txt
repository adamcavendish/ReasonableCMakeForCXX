cmake_minimum_required(VERSION 3.3)
project(project2 VERSION 1.0.0)

set(CMAKE_INSTALL_PREFIX "${CMAKE_SOURCE_DIR}/install/")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/../reason/")
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/../cotire/CMake/")

set(REASON_VERBOSE FALSE)
set(REASON_BRIEF_PATH FALSE)
include(reason)

message(STATUS "Configure ${PROJECT_NAME} (${PROJECT_VERSION})")
message(STATUS "Install directory: ${CMAKE_INSTALL_PREFIX}")

# If you installed project1 using 'dpkg -i ./project1.deb',
# you can just comment out the next line.
# It'll be found globally in '/usr/share/project1/'
set(CMAKE_PREFIX_PATH ${CMAKE_PREFIX_PATH} "${CMAKE_SOURCE_DIR}/../project1-integrate-reason-with-old-project/install")
find_package(module1)
find_package(module2)
find_package(module3)
find_package(project1)

reason_add_executable(TARGET "project2" SRCS "src/main.cpp" LINKS "project1_s" "module1_d" "module2_d" "module3_d")
reason_install(TARGETS "project2")
 
# Enable testing for testing submodules
reason_add_multiple_tests(TEST_NAME "test_project2" SRCS "test/test1_project2.cpp" LINKS "project1_s")
enable_testing()

# Pack deb
reason_pack_deb(
  CONTACT  "Firstname Lastname <email@example.com>"
  DESCSUM  "Project2 Short Desc"
  DESC     "Project2 Long Desc"
  ARCH     "amd64"
  DEBDEP   "libc6 (>= 2.4), project1 (>= 1.0.0)"
  SECTION  "devel"
  PRIORITY "optional")
include(CPack)
