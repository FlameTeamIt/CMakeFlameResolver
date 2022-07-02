cmake_minimum_required(VERSION 3.14)
project(test)

message(STATUS "Module path before find_package(): ${CMAKE_MODULE_PATH}")
find_package(CMakeFlameResolver REQUIRED)
message(STATUS "Module path after  find_package(): ${CMAKE_MODULE_PATH}")

include(CMakeFlameResolver)
message_warning("TESTIK WARNINK!")
