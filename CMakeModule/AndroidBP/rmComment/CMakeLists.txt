cmake_minimum_required(VERSION 3.6)
project(rm_comment)

set(CMAKE_CXX_STANDARD 14)
SET(CMAKE_EXE_LINKER_FLAGS "-static")
add_executable(rm_comment main.cpp)