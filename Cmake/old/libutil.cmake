if(ANDROID_LIB_UTILS)
    return()
endif()
SET(ANDROID_LIB_UTILS ON)

#project(libutils)

set(src_dir ${PROJECT_DIR}/system/core/libutils)

SET(libutils_common
        ${src_dir}/CallStack.cpp
        ${src_dir}/FileMap.cpp
        ${src_dir}/JenkinsHash.cpp
        ${src_dir}/LinearTransform.cpp
        ${src_dir}/Log.cpp
        ${src_dir}/NativeHandle.cpp
        ${src_dir}/Printer.cpp
        ${src_dir}/PropertyMap.cpp
        ${src_dir}/RefBase.cpp
        ${src_dir}/SharedBuffer.cpp
        ${src_dir}/Static.cpp
        ${src_dir}/StopWatch.cpp
        ${src_dir}/String8.cpp
        ${src_dir}/String16.cpp
        ${src_dir}/SystemClock.cpp
        ${src_dir}/Threads.cpp
        ${src_dir}/Timers.cpp
        ${src_dir}/Tokenizer.cpp
        ${src_dir}/Unicode.cpp
        ${src_dir}/VectorImpl.cpp
        ${src_dir}/misc.cpp)

SET(libutils_src
        ${src_dir}/BlobCache.cpp
        ${src_dir}/Looper.cpp
        ${src_dir}/ProcessCallStack.cpp
        ${src_dir}/Trace.cpp)

add_library(libutils ${libutils_src} ${libutils_common})
target_include_directories(libutils PUBLIC ${PROJECT_DIR}/external/safe-iop/include)
target_compile_options(libutils PUBLIC $<$<COMPILE_LANGUAGE:C>:-Werror -fvisibility=protected>)