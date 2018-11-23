if(ANDROID_RECOVERY)
    return()
endif()
SET(ANDROID_RECOVERY ON)

set(src_dir ${PROJECT_DIR}/bootable/recovery)

SET(recovery_common
        ${src_dir}/adb_install.cpp
        ${src_dir}/asn1_decoder.cpp
        ${src_dir}/device.cpp
        ${src_dir}/fuse_sdcard_provider.cpp
        ${src_dir}/install.cpp
        ${src_dir}/sdboot.cpp
        ${src_dir}/rktools.cpp
        ${src_dir}/recovery.cpp
        ${src_dir}/roots.cpp
        ${src_dir}/screen_ui.cpp
        ${src_dir}/ui.cpp
        ${src_dir}/verifier.cpp
        ${src_dir}/wear_ui.cpp
        ${src_dir}/wear_touch.cpp
        ${src_dir}/rkimage.cpp
        )

add_library(recovery ${recovery_common} )
target_include_directories(recovery PUBLIC
        ${PROJECT_DIR}/external/parted-3.2/include
        ${PROJECT_DIR}/system/vold
        ${PROJECT_DIR}/system/extras/ext4_utils
        ${PROJECT_DIR}/system/core/adb
        ${PROJECT_DIR}/external/e2fsprogs/lib
        ${PROJECT_DIR}/system/core/fs_mgr/include)
