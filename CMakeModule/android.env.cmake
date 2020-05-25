
if(EXISTS ${PROJECT_DIR}/android.env.cmake)
    include(${PROJECT_DIR}/android.env.cmake)
else("default")
    ########## get_build_var
    set(TARGET_BOARD_HARDWARE rk30board )
    ######### config your lunch target
    set(ANDROID_LUNCH rk3399)
    set(ANDROID_SDK_VERSION 28)
    set(ANDROID_TARGET_ARCH arm64)
    set(ANDROID_CPU_VARIANT "cortex-a53")
    ######### build abi
    #set(ANDROID_ABI "armeabi-v7a")
    #set(ANDROID_ABI "armeabi-v7a with NEON")
    set(ANDROID_ABI "arm64-v8a")
    #########window
    set(ANDROID_NDK "J://androidSdk/ndk-bundle")
endif()

#########
if(ANDROID_SDK_VERSION EQUAL 28)
    set(ANDROID_CLANG_VERSION "clang-4691093")
elseif(ANDROID_SDK_VERSION EQUAL 27)
    set(ANDROID_CLANG_VERSION "clang-4053586")
elseif(ANDROID_SDK_VERSION EQUAL 26)
    set(ANDROID_CLANG_VERSION "clang-4053586")
elseif(ANDROID_SDK_VERSION EQUAL 25)
    set(ANDROID_CLANG_VERSION "clang-2690385")
endif()


include(${CMAKE_CURRENT_LIST_DIR}/AndroidMK/LoadModule.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/AndroidMK/Parse.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/AndroidBP/Parse.cmake)
loadModule()
