cmake_minimum_required(VERSION 3.6.0-rc2)

SET(ANDROID_TEST_MODE OFF)
SET(PROJECT_DIR "${CMAKE_HOME_DIRECTORY}")
include(CMakeModule/android.env.cmake)
include(CMakeModule/android.func.cmake)
set(CMAKE_TOOLCHAIN_FILE ${PROJECT_DIR}/CMakeModule/android.toolchain.cmake)

project(Android)

if (ANDROID)
    message("Hello from Android build!")
endif()

ENABLE_LANGUAGE(ASM)

include_directories( SYSTEM
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
        "${PROJECT_DIR}/bionic/libc/kernel/android/uapi"
        "${PROJECT_DIR}/bionic/libc/kernel/common"
        "${PROJECT_DIR}/bionic/libc/kernel/uapi/asm-${ANDROID_SYSROOT_ABI}"
        "${PROJECT_DIR}/bionic/libm/include"
        "${PROJECT_DIR}/bionic/libm/include/${ANDROID_SYSROOT_ABI}"
        )

if(NOT ANDROID_TEST_MODE)
    include(CMakeModule/android.module.cmake)
endif()

if(EXISTS ${CMAKE_CURRENT_LIST_DIR}/android-test/CMakeLists.txt)
    add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/android-test)
endif()
