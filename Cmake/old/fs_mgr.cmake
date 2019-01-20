if(ANDROID_LIB_FS_MGR)
    return()
endif()
SET(ANDROID_LIB_FS_MGR ON)

#project(libcutils)

set(src_dir ${PROJECT_DIR}/system/core/fs_mgr)

SET(libfs_mgr_sources
        ${src_dir}/fs_mgr.c
        ${src_dir}/fs_mgr_format.c
        ${src_dir}/fs_mgr_fstab.c
        ${src_dir}/fs_mgr_slotselect.c
        ${src_dir}/fs_mgr_verity.cpp)

add_library(fs_mgr SHARED ${libfs_mgr_sources})
target_include_directories(fs_mgr PUBLIC
        ${src_dir}/include
        ${PROJECT_DIR}/system/vold
        ${PROJECT_DIR}/system/extras/ext4_utils
        ${PROJECT_DIR}/external/openssl/include
        ${PROJECT_DIR}/bootable/recovery
        ${PROJECT_DIR}/external/libcxx/include
        ${PROJECT_DIR}/external/libcxxabi/include
        ${PROJECT_DIR}/system/core/logwrapper/include
        ${PROJECT_DIR}/system/extras/libfec/include
        ${PROJECT_DIR}/system/core/base/include
        ${PROJECT_DIR}/external/boringssl/src/include
        )
