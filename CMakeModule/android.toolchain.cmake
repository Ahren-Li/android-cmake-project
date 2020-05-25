# Copyright (C) 2020 Ahren liliorg@163.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

cmake_minimum_required(VERSION 3.6.0)

set(CMAKE_SYSTEM_VERSION 1)

file(TO_CMAKE_PATH "${PROJECT_DIR}" PROJECT_DIR)
# ################################
if(ANDROID_NDK_TOOLCHAIN_INCLUDED)
    return()
endif(ANDROID_NDK_TOOLCHAIN_INCLUDED)
set(ANDROID_NDK_TOOLCHAIN_INCLUDED true)
# ################################

if(NOT ANDROID_ABI)
set(ANDROID_ABI "armeabi-v7a with NEON")
endif()

if(NOT ANDROID_CCACHE)
set(ANDROID_CCACHE OFF)
endif()

if(NOT ANDROID_ARM_MODE)
set(ANDROID_ARM_MODE thumb)
endif()

# Standard cross-compiling stuff.
set(ANDROID TRUE)
set(CMAKE_SYSTEM_NAME Android)

# Allow users to override these values in case they want more strict behaviors.
# For example, they may want to prevent the NDK's libz from being picked up so
# they can use their own.
# https://github.com/android-ndk/ndk/issues/517
if(NOT CMAKE_FIND_ROOT_PATH_MODE_PROGRAM)
    set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
endif()

if(NOT CMAKE_FIND_ROOT_PATH_MODE_LIBRARY)
    set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
endif()

if(NOT CMAKE_FIND_ROOT_PATH_MODE_INCLUDE)
    set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
endif()

if(NOT CMAKE_FIND_ROOT_PATH_MODE_PACKAGE)
    set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
endif()

# ABI
set(CMAKE_ANDROID_ARCH_ABI ${ANDROID_ABI})
if(ANDROID_ABI MATCHES "^armeabi(-v7a)?$")
    set(ANDROID_SYSROOT_ABI arm)
    set(ANDROID_TOOLCHAIN_NAME arm-linux-androideabi)
    set(ANDROID_TOOLCHAIN_ROOT ${ANDROID_TOOLCHAIN_NAME})
    set(ANDROID_HEADER_TRIPLE arm-linux-androideabi)
    if(ANDROID_ABI STREQUAL armeabi)
        message(WARNING "armeabi is deprecated and will be removed in a future NDK release.")
        set(CMAKE_SYSTEM_PROCESSOR armv5te)
        set(ANDROID_LLVM_TRIPLE armv5te-none-linux-androideabi)
    elseif(ANDROID_ABI STREQUAL armeabi-v7a)
        set(CMAKE_SYSTEM_PROCESSOR armv7-a)
        set(ANDROID_LLVM_TRIPLE armv7-none-linux-androideabi)
    endif()
elseif(ANDROID_ABI STREQUAL arm64-v8a)
    set(ANDROID_SYSROOT_ABI arm64)
    set(CMAKE_SYSTEM_PROCESSOR aarch64)
    set(ANDROID_TOOLCHAIN_NAME aarch64-linux-android)
    set(ANDROID_TOOLCHAIN_ROOT ${ANDROID_TOOLCHAIN_NAME})
    set(ANDROID_LLVM_TRIPLE aarch64-none-linux-android)
    set(ANDROID_HEADER_TRIPLE aarch64-linux-android)
elseif(ANDROID_ABI STREQUAL x86)
    set(ANDROID_SYSROOT_ABI x86)
    set(CMAKE_SYSTEM_PROCESSOR i686)
    set(ANDROID_TOOLCHAIN_NAME i686-linux-android)
    set(ANDROID_TOOLCHAIN_ROOT ${ANDROID_ABI})
    set(ANDROID_LLVM_TRIPLE i686-none-linux-android)
    set(ANDROID_HEADER_TRIPLE i686-linux-android)
elseif(ANDROID_ABI STREQUAL x86_64)
    set(ANDROID_SYSROOT_ABI x86_64)
    set(CMAKE_SYSTEM_PROCESSOR x86_64)
    set(ANDROID_TOOLCHAIN_NAME x86_64-linux-android)
    set(ANDROID_TOOLCHAIN_ROOT ${ANDROID_ABI})
    set(ANDROID_LLVM_TRIPLE x86_64-none-linux-android)
    set(ANDROID_HEADER_TRIPLE x86_64-linux-android)
elseif(ANDROID_ABI STREQUAL mips)
    set(ANDROID_SYSROOT_ABI mips)
    set(CMAKE_SYSTEM_PROCESSOR mips)
    set(ANDROID_TOOLCHAIN_NAME mips64el-linux-android)
    set(ANDROID_TOOLCHAIN_ROOT ${ANDROID_TOOLCHAIN_NAME})
    set(ANDROID_LLVM_TRIPLE mipsel-none-linux-android)
    set(ANDROID_HEADER_TRIPLE mipsel-linux-android)
elseif(ANDROID_ABI STREQUAL mips64)
    set(ANDROID_SYSROOT_ABI mips64)
    set(CMAKE_SYSTEM_PROCESSOR mips64)
    set(ANDROID_TOOLCHAIN_NAME mips64el-linux-android)
    set(ANDROID_TOOLCHAIN_ROOT ${ANDROID_TOOLCHAIN_NAME})
    set(ANDROID_LLVM_TRIPLE mips64el-none-linux-android)
    set(ANDROID_HEADER_TRIPLE mips64el-linux-android)
else()
    message(FATAL_ERROR "Invalid Android ABI: ${ANDROID_ABI}.")
endif()

if(ANDROID_SYSROOT_ABI STREQUAL arm)
    set(ANDROID_LIBDIR_NAME lib)
    if(ANDROID_TARGET_ARCH STREQUAL arm64)
        set(ANDROID_OBJ_DIR obj_arm)
    endif()
else()
    set(ANDROID_LIBDIR_NAME lib64)
    set(ANDROID_OBJ_DIR obj)
    if(ANDROID_TARGET_ARCH STREQUAL arm)
        message(FATAL_ERROR "android ANDROID_TARGET_ARCH=arm, but ANDROID_ABI=arm64-v8a")
    endif()
endif()

###########################################################################################################

set(ANDROID_COMPILER_FLAGS)
set(ANDROID_COMPILER_FLAGS_CXX)
set(ANDROID_COMPILER_FLAGS_DEBUG)
set(ANDROID_COMPILER_FLAGS_RELEASE)
set(ANDROID_LINKER_FLAGS)
set(ANDROID_LINKER_FLAGS_EXE)
SET(ANDROID_LINKER_FLAGS_SHARD)

# STL.
set(ANDROID_STL_STATIC_LIBRARIES)
set(ANDROID_STL_SHARED_LIBRARIES)

# out
set(ANDROID_TARGET_OUT_DIR ${PROJECT_DIR}/out/target/product/${ANDROID_LUNCH})

# Behavior of CMAKE_SYSTEM_LIBRARY_PATH and CMAKE_LIBRARY_PATH are really weird
# when CMAKE_SYSROOT is set. The library path is appended to the sysroot even if
# the library path is an abspath. Using a relative path from the sysroot doesn't
# work either, because the relative path is abspath'd relative to the current
# CMakeLists.txt file before being appended :(
#
# We can try to get out of this problem by providing another root path for cmake
# to check. CMAKE_FIND_ROOT_PATH is intended for this purpose:
# https://cmake.org/cmake/help/v3.8/variable/CMAKE_FIND_ROOT_PATH.html
#
# In theory this should just be our sysroot, but since we don't have a single
# sysroot that is correct (there's only one set of headers, but multiple
# locations for libraries that need to be handled differently).  Some day we'll
# want to move all the libraries into ${ANDROID_NDK}/sysroot, but we'll need to
# make some fixes to Clang, various build systems, and possibly CMake itself to
# get that working.
list(APPEND CMAKE_FIND_ROOT_PATH "${PROJECT_DIR}/bionic/libc")

# We need different sysroots for linking and compiling, but cmake doesn't
# support that. Pass the sysroot flag manually when linking.
set(ANDROID_SYSTEM_LIBRARY_PATH "${ANDROID_TARGET_OUT_DIR}/symbols/system/${ANDROID_LIBDIR_NAME}")

# find_library searches a handful of paths as described by
# https://cmake.org/cmake/help/v3.6/command/find_library.html.  Since libraries
# are per-API level and headers aren't, We don't have libraries in the
# CMAKE_SYSROOT. Set up CMAKE_SYSTEM_LIBRARY_PATH
# (https://cmake.org/cmake/help/v3.6/variable/CMAKE_SYSTEM_LIBRARY_PATH.html)
# instead.
#
# NB: The suffix is just lib here instead of dealing with lib64 because
# apparently CMake does some automatic rewriting of that? I've been testing by
# building my own CMake with a bunch of logging added, and that seems to be the
# case.
list(APPEND CMAKE_SYSTEM_LIBRARY_PATH "${ANDROID_SYSTEM_LIBRARY_PATH}")

# Toolchain.
if(CMAKE_HOST_SYSTEM_NAME STREQUAL Linux)
    set(ANDROID_HOST_TAG linux-x86)
    elseif(CMAKE_HOST_SYSTEM_NAME STREQUAL Darwin)
      set(ANDROID_HOST_TAG darwin-x86_64)
elseif(CMAKE_HOST_SYSTEM_NAME STREQUAL Windows)
    set(ANDROID_HOST_TAG windows-x86_64)
    set(ANDROID_TOOLCHAIN_SUFFIX .exe)
    if(NOT ANDROID_NDK)
        message(FATAL_ERROR "Android NDK not set!")
        return()
    endif()
endif()

################toolchain
set(ANDROID_TOOLCHAIN_ROOT
        "${PROJECT_DIR}/prebuilts/gcc/${ANDROID_HOST_TAG}/${CMAKE_SYSTEM_PROCESSOR}/${ANDROID_TOOLCHAIN_NAME}-4.9")
if ("${ANDROID_HOST_TAG}" MATCHES "windows.*")
    set(ANDROID_TOOLCHAIN_ROOT "${ANDROID_NDK}/toolchains/${ANDROID_TOOLCHAIN_NAME}-4.9/prebuilt/${ANDROID_HOST_TAG}")
endif ()
set(ANDROID_TOOLCHAIN_PREFIX "${ANDROID_TOOLCHAIN_ROOT}/bin/${ANDROID_TOOLCHAIN_NAME}-")

if ("${ANDROID_HOST_TAG}" MATCHES "windows.*")
    set(ANDROID_LLVM_TOOLCHAIN_PREFIX "${ANDROID_NDK}/toolchains/llvm/prebuilt/${ANDROID_HOST_TAG}/bin/")
else()
    if(NOT ANDROID_CLANG_VERSION)
        set(ANDROID_CLANG_VERSION "clang-2690385")
    endif()
    set(ANDROID_LLVM_TOOLCHAIN_PREFIX "${PROJECT_DIR}/prebuilts/clang/host/${ANDROID_HOST_TAG}/${ANDROID_CLANG_VERSION}/bin/")
endif()
set(ANDROID_C_COMPILER   "${ANDROID_LLVM_TOOLCHAIN_PREFIX}clang${ANDROID_TOOLCHAIN_SUFFIX}")
set(ANDROID_CXX_COMPILER "${ANDROID_LLVM_TOOLCHAIN_PREFIX}clang++${ANDROID_TOOLCHAIN_SUFFIX}")
set(ANDROID_ASM_COMPILER "${ANDROID_LLVM_TOOLCHAIN_PREFIX}clang${ANDROID_TOOLCHAIN_SUFFIX}")
# Clang can fail to compile if CMake doesn't correctly supply the target and
# external toolchain, but to do so, CMake needs to already know that the
# compiler is clang. Tell CMake that the compiler is really clang, but don't
# use CMakeForceCompiler, since we still want compile checks. We only want
# to skip the compiler ID detection step.
set(CMAKE_C_COMPILER_ID_RUN TRUE)
set(CMAKE_CXX_COMPILER_ID_RUN TRUE)
set(CMAKE_C_COMPILER_ID Clang)
set(CMAKE_CXX_COMPILER_ID Clang)
set(CMAKE_C_COMPILER_VERSION 3.8)
set(CMAKE_CXX_COMPILER_VERSION 3.8)
set(CMAKE_C_STANDARD_COMPUTED_DEFAULT 11)
set(CMAKE_CXX_STANDARD_COMPUTED_DEFAULT 98)

set(CMAKE_C_COMPILER_EXTERNAL_TOOLCHAIN   "${ANDROID_TOOLCHAIN_ROOT}")
set(CMAKE_CXX_COMPILER_EXTERNAL_TOOLCHAIN "${ANDROID_TOOLCHAIN_ROOT}")
set(CMAKE_ASM_COMPILER_EXTERNAL_TOOLCHAIN "${ANDROID_TOOLCHAIN_ROOT}")

if(EXISTS ${ANDROID_LLVM_TOOLCHAIN_PREFIX}llvm-ar${ANDROID_TOOLCHAIN_SUFFIX})
    set(ANDROID_AR     "${ANDROID_LLVM_TOOLCHAIN_PREFIX}llvm-ar${ANDROID_TOOLCHAIN_SUFFIX}")
else()
    set(ANDROID_AR     "${ANDROID_TOOLCHAIN_PREFIX}ar${ANDROID_TOOLCHAIN_SUFFIX}")
endif()
if(EXISTS ${ANDROID_LLVM_TOOLCHAIN_PREFIX}llvm-ranlib${ANDROID_TOOLCHAIN_SUFFIX})
    set(ANDROID_RANLIB "${ANDROID_LLVM_TOOLCHAIN_PREFIX}llvm-ranlib${ANDROID_TOOLCHAIN_SUFFIX}")
else()
    set(ANDROID_RANLIB "${ANDROID_TOOLCHAIN_PREFIX}ranlib${ANDROID_TOOLCHAIN_SUFFIX}")
endif()

if(ANDROID_CCACHE)
    set(CMAKE_C_COMPILER_LAUNCHER   "${ANDROID_CCACHE}")
    set(CMAKE_CXX_COMPILER_LAUNCHER "${ANDROID_CCACHE}")
endif()

set(CMAKE_C_COMPILER        "${ANDROID_C_COMPILER}")
set(CMAKE_CXX_COMPILER      "${ANDROID_CXX_COMPILER}")
set(CMAKE_AR                "${ANDROID_AR}" CACHE FILEPATH "Archiver")
set(CMAKE_RANLIB            "${ANDROID_RANLIB}" CACHE FILEPATH "Ranlib")
set(_CMAKE_TOOLCHAIN_PREFIX "${ANDROID_TOOLCHAIN_PREFIX}")

if(ANDROID_ABI STREQUAL "x86" OR ANDROID_ABI STREQUAL "x86_64")
    set(CMAKE_ASM_NASM_COMPILER
            "${ANDROID_HOST_PREBUILTS}/bin/yasm${ANDROID_TOOLCHAIN_SUFFIX}")
    set(CMAKE_ASM_NASM_COMPILER_ARG1 "-DELF")
endif()

include(${CMAKE_CURRENT_LIST_DIR}/android.func.cmake)
################flag
include(${CMAKE_CURRENT_LIST_DIR}/android.flag.cmake)

list(APPEND ANDROID_COMPILER_FLAGS     -DPLATFORM_SDK_VERSION=${ANDROID_SDK_VERSION})
list(APPEND ANDROID_COMPILER_FLAGS_CXX -DPLATFORM_SDK_VERSION=${ANDROID_SDK_VERSION})

# Set or retrieve the cached flags.
# This is necessary in case the user sets/changes flags in subsequent
# configures. If we included the Android flags in here, they would get
# overwritten.
set(CMAKE_C_FLAGS ""
        CACHE STRING "Flags used by the compiler during all build types.")
set(CMAKE_CXX_FLAGS ""
        CACHE STRING "Flags used by the compiler during all build types.")
set(CMAKE_ASM_FLAGS ""
        CACHE STRING "Flags used by the compiler during all build types.")
set(CMAKE_C_FLAGS_DEBUG ""
        CACHE STRING "Flags used by the compiler during debug builds.")
set(CMAKE_CXX_FLAGS_DEBUG ""
        CACHE STRING "Flags used by the compiler during debug builds.")
set(CMAKE_ASM_FLAGS_DEBUG ""
        CACHE STRING "Flags used by the compiler during debug builds.")
set(CMAKE_C_FLAGS_RELEASE ""
        CACHE STRING "Flags used by the compiler during release builds.")
set(CMAKE_CXX_FLAGS_RELEASE ""
        CACHE STRING "Flags used by the compiler during release builds.")
set(CMAKE_ASM_FLAGS_RELEASE ""
        CACHE STRING "Flags used by the compiler during release builds.")
set(CMAKE_MODULE_LINKER_FLAGS ""
        CACHE STRING "Flags used by the linker during the creation of modules.")
set(CMAKE_SHARED_LINKER_FLAGS ""
        CACHE STRING "Flags used by the linker during the creation of dll's.")
set(CMAKE_EXE_LINKER_FLAGS ""
        CACHE STRING "Flags used by the linker.")

string(REPLACE ";" " " ANDROID_COMPILER_FLAGS           "${ANDROID_COMPILER_FLAGS}")
string(REPLACE ";" " " ANDROID_COMPILER_FLAGS_CXX       "${ANDROID_COMPILER_FLAGS_CXX}")
string(REPLACE ";" " " ANDROID_COMPILER_FLAGS_DEBUG     "${ANDROID_COMPILER_FLAGS_DEBUG}")
string(REPLACE ";" " " ANDROID_COMPILER_FLAGS_RELEASE   "${ANDROID_COMPILER_FLAGS_RELEASE}")
string(REPLACE ";" " " ANDROID_LINKER_FLAGS             "${ANDROID_LINKER_FLAGS}")
string(REPLACE ";" " " ANDROID_LINKER_FLAGS_EXE         "${ANDROID_LINKER_FLAGS_EXE}")
string(REPLACE ";" " " ANDROID_LDFLAGS_EXE              "${ANDROID_LDFLAGS_EXE}")
string(REPLACE ";" " " ANDROID_LINKER_FLAGS_SHARED      "${ANDROID_LINKER_FLAGS_SHARED}")

set(CMAKE_C_FLAGS             ${ANDROID_COMPILER_FLAGS})
set(CMAKE_CXX_FLAGS           ${ANDROID_COMPILER_FLAGS_CXX})
set(CMAKE_ASM_FLAGS           ${ANDROID_COMPILER_FLAGS})

set(CMAKE_C_FLAGS_DEBUG       ${ANDROID_COMPILER_FLAGS_DEBUG})
set(CMAKE_CXX_FLAGS_DEBUG     ${ANDROID_COMPILER_FLAGS_DEBUG})
set(CMAKE_ASM_FLAGS_DEBUG     ${ANDROID_COMPILER_FLAGS_DEBUG})

set(CMAKE_C_FLAGS_RELEASE     ${ANDROID_COMPILER_FLAGS_RELEASE})
set(CMAKE_CXX_FLAGS_RELEASE   ${ANDROID_COMPILER_FLAGS_RELEASE})
set(CMAKE_ASM_FLAGS_RELEASE   ${ANDROID_COMPILER_FLAGS_RELEASE})

# link
set(CMAKE_SHARED_LINKER_FLAGS  ${ANDROID_LINKER_FLAGS_SHARED})
set(CMAKE_MODULE_LINKER_FLAGS  ${ANDROID_LINKER_FLAGS_SHARED})
set(CMAKE_EXE_LINKER_FLAGS     ${ANDROID_LINKER_FLAGS_EXE})

set(CMAKE_ASM_CREATE_SHARED_LIBRARY
        "ld -E -b <CMAKE_SHARED_LIBRARY_SONAME_ASM_FLAG><TARGET_SONAME> <LINK_FLAGS> -o <TARGET> <OBJECTS> <LINK_LIBRARIES>")

set(CMAKE_C_CREATE_SHARED_LIBRARY
        "<CMAKE_C_COMPILER> <SONAME_FLAG><TARGET_SONAME> <LINK_FLAGS> <OBJECTS> ${ANDROID_LDFLAGS_EXE} -o <TARGET> ${ANDROID_CRTEND_SO} <LINK_LIBRARIES>")
set(CMAKE_CXX_CREATE_SHARED_LIBRARY
      "<CMAKE_CXX_COMPILER> <SONAME_FLAG><TARGET_SONAME> <LINK_FLAGS> <OBJECTS> ${ANDROID_LDFLAGS_EXE} -o <TARGET> ${ANDROID_CRTEND_SO} <LINK_LIBRARIES>")
set(CMAKE_C_CREATE_SHARED_MODULE
        "<CMAKE_C_COMPILER> <SONAME_FLAG><TARGET_SONAME> <LINK_FLAGS> <OBJECTS> ${ANDROID_LDFLAGS_EXE} -o <TARGET> ${ANDROID_CRTEND_SO} <LINK_LIBRARIES>")
set(CMAKE_CXX_CREATE_SHARED_MODULE
      "<CMAKE_CXX_COMPILER> <SONAME_FLAG><TARGET_SONAME> <LINK_FLAGS> <OBJECTS> ${ANDROID_LDFLAGS_EXE} -o <TARGET> ${ANDROID_CRTEND_SO} <LINK_LIBRARIES>")

set(CMAKE_C_LINK_EXECUTABLE
        "<CMAKE_C_COMPILER> <LINK_FLAGS> <OBJECTS> ${ANDROID_LDFLAGS_EXE} -o <TARGET> ${ANDROID_CRTEND_O} <LINK_LIBRARIES>")
set(CMAKE_CXX_LINK_EXECUTABLE
        "<CMAKE_CXX_COMPILER> <LINK_FLAGS> <OBJECTS> ${ANDROID_LDFLAGS_EXE} -o <TARGET> ${ANDROID_CRTEND_O} <LINK_LIBRARIES>")

#static lib
set(CMAKE_C_ARCHIVE_CREATE "<CMAKE_AR> cqsD -format=gnu <TARGET> <OBJECTS>")
set(CMAKE_CXX_ARCHIVE_CREATE "<CMAKE_AR> cqsD -format=gnu <TARGET> <OBJECTS>")

# Export configurable variables for the try_compile() command.
set(CMAKE_TRY_COMPILE_PLATFORM_VARIABLES
        PROJECT_DIR
        ANDROID_NDK
        ANDROID_LUNCH
        ANDROID_TARGET_ARCH
        ANDROID_TOOLCHAIN
        ANDROID_CPU_VARIANT
        ANDROID_ABI
        ANDROID_ARM_MODE
        CMAKE_C_LINK_EXECUTABLE
        CMAKE_CXX_LINK_EXECUTABLE
        #        ANDROID_PLATFORM
        #        ANDROID_STL
        #        ANDROID_PIE
        #        ANDROID_CPP_FEATURES
        #        ANDROID_ALLOW_UNDEFINED_SYMBOLS
        #        ANDROID_ARM_MODE
        #        ANDROID_ARM_NEON
        #        ANDROID_DISABLE_NO_EXECUTE
        #        ANDROID_DISABLE_RELRO
        #        ANDROID_DISABLE_FORMAT_STRING_CHECKS
        ANDROID_CCACHE
        ANDROID_SDK_VERSION
        )