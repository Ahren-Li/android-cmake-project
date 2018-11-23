
set(ANDROID_NDK /data/lili/AndroidNDK/android-ndk-r16b)
#set(ANDROID_ABI "armeabi-v7a with NEON")
set(ANDROID_ABI "arm64-v8a")
set(ANDROID_TOOLCHAIN_NAME "clang")
set(ANDROID_STL c++_static)
#set(ANDROID_PLATFORM android-25)
set(ANDROID_NATIVE_API_LEVEL 25)
set(CMAKE_TOOLCHAIN_FILE ${ANDROID_NDK}/build/cmake/android.toolchain.cmake)
ENABLE_LANGUAGE(ASM)

if (ANDROID)
        message(STATUS "Hello from Android build!")
endif()

message("CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES:${CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES}")
message("CMAKE_CXX_INCLUDE_WHAT_YOU_USE:${CMAKE_CXX_INCLUDE_WHAT_YOU_USE}")
message("CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES:${CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES}")
message("CMAKE_SYSROOT:${CMAKE_SYSROOT}")

UNSET(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES)
UNSET(CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES)

#/system
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

SET(CMAKE_C_FLAGS
        "${CMAKE_C_FLAGS} \
        --target=armv7-none-linux-androideabi \
        -DANDROID -std=gnu99
        ")

SET(CMAKE_CXX_FLAGS
        "${CMAKE_CXX_FLAGS} \
        --target=armv7-none-linux-androideabi \
        -DANDROID
        ")


#set(CMAKE_C_STANDARD   99)
#set(CMAKE_ASM_STANDARD 99)
set(CMAKE_CXX_STANDARD 14)
