if(ANDROID_LIB_INIT)
    return()
endif()
SET(ANDROID_LIB_INIT ON)

set(src_dir ${PROJECT_DIR}/system/core/init)

SET(init_sources
        ${src_dir}/action.cpp
        ${src_dir}/import_parser.cpp
        ${src_dir}/init_parser.cpp
        ${src_dir}/log.cpp
        ${src_dir}/parser.cpp
        ${src_dir}/service.cpp
        ${src_dir}/util.cpp
        ${src_dir}/bootchart.cpp
        ${src_dir}/builtins.cpp
        ${src_dir}/devices.cpp
        ${src_dir}/init.cpp
        ${src_dir}/keychords.cpp
        ${src_dir}/property_service.cpp
        ${src_dir}/signal_handler.cpp
        ${src_dir}/ueventd.cpp
        ${src_dir}/ueventd_parser.cpp
        ${src_dir}/watchdogd.cpp
        )

if(EXISTS  ${src_dir}/vendor.cpp)
    set(init_sources ${init_sources} ${src_dir}/vendor.cpp)
endif()

add_library(init SHARED ${init_sources})

target_compile_definitions( init PUBLIC  -DALLOW_LOCAL_PROP_OVERRIDE=1 -DALLOW_DISABLE_SELINUX=1 -DLOG_UEVENTS=0 -DTARGET_BOARD_PLATFORM_PRODUCT_BOX )

target_include_directories(init PUBLIC
        ${PROJECT_DIR}/system/extras/ext4_utils
        ${PROJECT_DIR}/system/core/mkbootimg)
