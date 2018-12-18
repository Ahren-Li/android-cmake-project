if(ANDROID_LIB_CUTILS)
    return()
endif()
SET(ANDROID_LIB_CUTILS ON)

#project(libcutils)

set(src_dir ${PROJECT_DIR}/system/core/libcutils)

SET(libcutils_common_sources
        ${src_dir}/atomic.c
        ${src_dir}/config_utils.c
        ${src_dir}/fs_config.c
        ${src_dir}/canned_fs_config.c
        ${src_dir}/hashmap.c
        ${src_dir}/iosched_policy.c
        ${src_dir}/load_file.c
        ${src_dir}/native_handle.c
        ${src_dir}/open_memstream.c
        ${src_dir}/process_name.c
        ${src_dir}/record_stream.c
        ${src_dir}/sched_policy.c
        ${src_dir}/sockets.cpp
        ${src_dir}/strdup16to8.c
        ${src_dir}/strdup8to16.c
        ${src_dir}/strlcpy.c
        ${src_dir}/threads.c)

SET(libcutils_nonwindows_sources
        ${src_dir}/fs.c
        ${src_dir}/multiuser.c
        ${src_dir}/socket_inaddr_any_server_unix.c
        ${src_dir}/socket_local_client_unix.c
        ${src_dir}/socket_local_server_unix.c
        ${src_dir}/socket_loopback_client_unix.c
        ${src_dir}/socket_loopback_server_unix.c
        ${src_dir}/socket_network_client_unix.c
        ${src_dir}/sockets_unix.cpp
        ${src_dir}/str_parms.c)

SET(libcutils_sources
        ${src_dir}/android_reboot.c
        ${src_dir}/ashmem-dev.c
        ${src_dir}/debugger.c
        ${src_dir}/klog.c
        ${src_dir}/partition_utils.c
        ${src_dir}/properties.c
        ${src_dir}/qtaguid.c
        ${src_dir}/trace-dev.c
        ${src_dir}/uevent.c)

if("${ANDROID_ABI}" STREQUAL "armeabi-v7a")
    SET(libcutils_asm ${src_dir}/arch-arm/memset32.S)
else()
    SET(libcutils_asm ${src_dir}/arch-arm64/android_memset.S)
endif()

add_library(cutils SHARED ${libcutils_common_sources} ${libcutils_nonwindows_sources} ${libcutils_sources} ${libcutils_asm})
target_compile_options(cutils PUBLIC $<$<COMPILE_LANGUAGE:C>:-std=gnu90>)
target_compile_options(cutils PUBLIC $<$<COMPILE_LANGUAGE:C>:-Werror -Wall -Wextra>)

target_link_libraries(cutils
        ${PROJECT_DIR}/out/target/product/${ANDROID_LUNCH}/obj/STATIC_LIBRARIES/liblog_intermediates/liblog.a)
