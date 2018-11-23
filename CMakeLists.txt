cmake_minimum_required(VERSION 3.6.0-rc2)

SET(ANDROID_DEBUG OFF)
SET(PROJECT_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
#list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/Cmake")
#include(Cmake/source_clang.cmake)
#project(Android)
#return()

message("PROJECT_DIR:${PROJECT_DIR}")

#set(ANDROID_NDK /data/lili/AndroidNDK/android-ndk-r16b)
#set(ANDROID_ABI "armeabi-v7a with NEON")
set(ANDROID_ABI "arm64-v8a")
set(ANDROID_TOOLCHAIN_NAME "clang")
set(ANDROID_STL c++_static)
#set(ANDROID_PLATFORM android-25)
#set(ANDROID_NATIVE_API_LEVEL 25)

set(CMAKE_TOOLCHAIN_FILE Cmake/android.toolchain.cmake)

#set(CMAKE_TOOLCHAIN_FILE /data/lili/AndroidNDK/android-ndk-r16b/build/cmake/android.toolchain.cmake)
ENABLE_LANGUAGE(ASM)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/Cmake")

if (ANDROID)
    message(STATUS "Hello from Android build!")
endif()

if (ANDROID_DEBUG)
    message("CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES:${CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES}")
    message("CMAKE_CXX_INCLUDE_WHAT_YOU_USE:${CMAKE_CXX_INCLUDE_WHAT_YOU_USE}")
    message("CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES:${CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES}")
    message("CMAKE_SYSROOT:${CMAKE_SYSROOT}")


    message(CMAKE_SYSROOT      ${CMAKE_SYSROOT})
    message(CMAKE_SYSROOT_COMPILE      ${CMAKE_SYSROOT_COMPILE})
    message(CMAKE_C_LINK_EXECUTABLE      ${CMAKE_C_LINK_EXECUTABLE})
    message(CMAKE_C_COMPILER        ${CMAKE_C_COMPILER})
    message(CMAKE_CXX_COMPILER      ${CMAKE_CXX_COMPILER})
    message(CMAKE_AR                ${CMAKE_AR})

    message(CMAKE_C_FLAGS             ${CMAKE_C_FLAGS})
    message(CMAKE_CXX_FLAGS           ${CMAKE_CXX_FLAGS})
    message(CMAKE_ASM_FLAGS           ${CMAKE_ASM_FLAGS})
    message(CMAKE_C_FLAGS_DEBUG       ${CMAKE_C_FLAGS_DEBUG})
    message(CMAKE_CXX_FLAGS_DEBUG     ${CMAKE_CXX_FLAGS_DEBUG})
    message(CMAKE_ASM_FLAGS_DEBUG     ${CMAKE_ASM_FLAGS_DEBUG})
    message(CMAKE_C_FLAGS_RELEASE     ${CMAKE_C_FLAGS_RELEASE})
    message(CMAKE_CXX_FLAGS_RELEASE   ${CMAKE_CXX_FLAGS_RELEASE})
    message(CMAKE_ASM_FLAGS_RELEASE   ${CMAKE_ASM_FLAGS_RELEASE})
    message(CMAKE_SHARED_LINKER_FLAGS ${CMAKE_SHARED_LINKER_FLAGS})
    message(CMAKE_MODULE_LINKER_FLAGS ${CMAKE_MODULE_LINKER_FLAGS})
    message(CMAKE_EXE_LINKER_FLAGS    ${CMAKE_EXE_LINKER_FLAGS})
endif()
#system
include_directories( SYSTEM
        "${PROJECT_DIR}/system/core/include"
        "${PROJECT_DIR}/system/media/audio/include"
        "${PROJECT_DIR}/hardware/libhardware/include"
        "${PROJECT_DIR}/hardware/libhardware_legacy/include"
        "${PROJECT_DIR}/libnativehelper/include"
        "${PROJECT_DIR}/frameworks/native/include"
        "${PROJECT_DIR}/frameworks/native/opengl/include"
        "${PROJECT_DIR}/frameworks/av/include"
        "${PROJECT_DIR}/frameworks/base/include"
        "${PROJECT_DIR}/out/target/product/rk3399_box/obj/include"
        "${PROJECT_DIR}/bionic/libc/arch-arm/include"
        "${PROJECT_DIR}/bionic/libc/include"
        "${PROJECT_DIR}/bionic/libc/kernel/uapi"
        "${PROJECT_DIR}/bionic/libc/kernel/common"
        "${PROJECT_DIR}/bionic/libc/kernel/uapi/asm-arm"
        "${PROJECT_DIR}/bionic/libm/include"
        "${PROJECT_DIR}/bionic/libm/include/arm"
        )

project(Android)

UNSET(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES)
UNSET(CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES)

#SET(CMAKE_C_FLAGS
#        "${CMAKE_C_FLAGS}
#        -D_LIBC=1
#        --target=armv7-none-linux-androideabi
#        -DANDROID
#        -std=gnu99
#        ")
#
#SET(CMAKE_CXX_FLAGS
#        "${CMAKE_CXX_FLAGS}
#        --target=armv7-none-linux-androideabi
#        -DANDROID
#        ")


#set(CMAKE_C_STANDARD   99)
#set(CMAKE_ASM_STANDARD 99)
#set(CMAKE_CXX_STANDARD 14)

include(libcutils)
include(libutil)
include(libui)
include(libgui)
include(libbinder)
include(SurfaceFlinger)
#include(rockchip_audio)
#include(rockchip_drmservice)
#include(audiopolicy)
#include(init)
include(recovery)

if(EXISTS ${CMAKE_CURRENT_LIST_DIR}/lili-test)
    add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/lili-test)
endif()