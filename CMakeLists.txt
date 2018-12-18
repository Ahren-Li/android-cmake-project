cmake_minimum_required(VERSION 3.6.0-rc2)

SET(ANDROID_DEBUG OFF)

SET(PROJECT_DIR "${CMAKE_HOME_DIRECTORY}")
include(${PROJECT_DIR}/env_android.cmake)
list(APPEND CMAKE_MODULE_PATH "${PROJECT_DIR}/Cmake")

set(CMAKE_TOOLCHAIN_FILE ${PROJECT_DIR}/android.toolchain.cmake)

project(Android)

if (ANDROID)
    message("Hello from Android build!")
endif()

ENABLE_LANGUAGE(ASM)

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
include_directories(
        ${PROJECT_DIR}/libnativehelper/include/nativehelper
        ${PROJECT_DIR}/external/libcxx/include
        ${PROJECT_DIR}/external/libcxxabi/include
)
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
        "${PROJECT_DIR}/out/target/product/${ANDROID_LUNCH}/obj/include"
        "${PROJECT_DIR}/bionic/libc/arch-${ANDROID_SYSROOT_ABI}/include"
        "${PROJECT_DIR}/bionic/libc/include"
        "${PROJECT_DIR}/bionic/libc/kernel/uapi"
        "${PROJECT_DIR}/bionic/libc/kernel/common"
        "${PROJECT_DIR}/bionic/libc/kernel/uapi/asm-${ANDROID_SYSROOT_ABI}"
        "${PROJECT_DIR}/bionic/libm/include"
        "${PROJECT_DIR}/bionic/libm/include/${ANDROID_SYSROOT_ABI}"
        )

include(libcutils)
include(libutil)
include(libui)
include(libgui)
include(libbinder)
include(SurfaceFlinger)

if(EXISTS ${CMAKE_CURRENT_LIST_DIR}/android-test/CMakeLists.txt)
    add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/android-test)
endif()
