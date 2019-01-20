if(ANDROID_LIB_UI)
    return()
endif()
SET(ANDROID_LIB_UI ON)

set(src_dir ${PROJECT_DIR}/frameworks/native/libs/ui)

SET(libui_src
        ${src_dir}/Fence.cpp
        ${src_dir}/FrameStats.cpp
        ${src_dir}/Gralloc1.cpp
        ${src_dir}/Gralloc1On0Adapter.cpp
        ${src_dir}/GraphicBuffer.cpp
        ${src_dir}/GraphicBufferAllocator.cpp
        ${src_dir}/GraphicBufferMapper.cpp
        ${src_dir}/HdrCapabilities.cpp
        ${src_dir}/PixelFormat.cpp
        ${src_dir}/Rect.cpp
        ${src_dir}/Region.cpp 
        ${src_dir}/UiConfig.cpp)


add_library(libui ${libui_src} )

target_compile_options(libui PUBLIC $<$<COMPILE_LANGUAGE:CXX>:-std=c++1y -Weverything -Werror>)

# The static constructors and destructors in this library have not been noted to
# introduce significant overheads
target_compile_options(libui PUBLIC $<$<COMPILE_LANGUAGE:CXX>:-Wno-exit-time-destructors -Wno-global-constructors>)

# We only care about compiling as C++14
target_compile_options(libui PUBLIC $<$<COMPILE_LANGUAGE:CXX>:-Wno-c++98-compat-pedantic>)

# We don't need to enumerate every case in a switch as long as a default case
# is present
target_compile_options(libui PUBLIC $<$<COMPILE_LANGUAGE:CXX>:-Wno-switch-enum>)

# Allow calling variadic macros without a __VA_ARGS__ list
target_compile_options(libui PUBLIC $<$<COMPILE_LANGUAGE:CXX>:-Wno-gnu-zero-variadic-macro-arguments>)

# Don't warn about struct padding
target_compile_options(libui PUBLIC $<$<COMPILE_LANGUAGE:CXX>:-Wno-padded>)



