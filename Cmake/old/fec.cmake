if(ANDROID_LIB_FEC)
    return()
endif()
SET(ANDROID_LIB_FEC ON)

#project(libcutils)

set(src_dir ${PROJECT_DIR}/system/extras/libfec)

SET(libfec_sources
        ${src_dir}/fec_open.cpp
        ${src_dir}/fec_read.cpp
        ${src_dir}/fec_verity.cpp
        ${src_dir}/fec_process.cpp
        )

add_library(fec SHARED ${libfec_sources})
target_include_directories(fec PUBLIC
        ${src_dir}/include
        ${PROJECT_DIR}/external/libcxx/include
        ${PROJECT_DIR}/external/libcxxabi/include
        ${PROJECT_DIR}/external/fec
        ${PROJECT_DIR}/system/extras/ext4_utils
        ${PROJECT_DIR}/system/extras/squashfs_utils
        )
