
add_executable(test-exec main.c)

add_library(libtest STATIC test.c)

target_include_directories(test-exec PUBLIC
        include
        ${PROJECT_DIR}/external/libpng
        ${PROJECT_DIR}/external/libusb/include
        ${PROJECT_DIR}/external/zlib
        ${PROJECT_DIR}/external/libnl/include
        ${PROJECT_DIR}/bionic/libc/include
        ${PROJECT_DIR}/system/core/libcutils/include
        )

target_include_directories(libtest PUBLIC include)

# aarch64-linux-android-4.9 根据自己的源码配置
# aarch64-linux-android-4.9 Configure according to your own source code
target_compile_options(test-exec PRIVATE
        -target aarch64-linux-android
        -B${PROJECT_DIR}/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/aarch64-linux-android/bin
        )

target_link_options(test-exec PRIVATE
        -target aarch64-linux-android
        -B${PROJECT_DIR}/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/aarch64-linux-android/bin
        )

target_compile_options(libtinyalsa-vamrs PRIVATE
        -target aarch64-linux-android
        -B${PROJECT_DIR}/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/aarch64-linux-android/bin
        )

target_link_options(libtinyalsa-vamrs PRIVATE
        -target aarch64-linux-android
        -B${PROJECT_DIR}/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/aarch64-linux-android/bin
        )

target_link_libraries( test-exec PRIVATE libtest)

target_link_libraries(test-exec PRIVATE
        ${PROJECT_DIR}/out/target/product/${ANDROID_LUNCH}/obj/STATIC_LIBRARIES/libminuitwrp-vamrs_intermediates/libminuitwrp-vamrs.a
        ${PROJECT_DIR}/out/target/product/${ANDROID_LUNCH}/obj/STATIC_LIBRARIES/libpixelflinger-vamrs_intermediates/libpixelflinger-vamrs.a
        ${PROJECT_DIR}/out/target/product/${ANDROID_LUNCH}/obj/STATIC_LIBRARIES/libft2-vamrs_intermediates/libft2-vamrs.a
        ${PROJECT_DIR}/out/target/product/${ANDROID_LUNCH}/obj/SHARED_LIBRARIES/libnl_intermediates/libnl.so
        ${PROJECT_DIR}/out/target/product/${ANDROID_LUNCH}/obj/SHARED_LIBRARIES/libpng_intermediates/libpng.so
        ${PROJECT_DIR}/out/target/product/${ANDROID_LUNCH}/obj/SHARED_LIBRARIES/libusb_intermediates/libusb.so
        ${PROJECT_DIR}/out/target/product/${ANDROID_LUNCH}/obj/SHARED_LIBRARIES/liblog_intermediates/liblog.so
        ${PROJECT_DIR}/out/target/product/${ANDROID_LUNCH}/obj/SHARED_LIBRARIES/liblzma_intermediates/liblzma.so
        ${PROJECT_DIR}/out/target/product/${ANDROID_LUNCH}/obj/SHARED_LIBRARIES/libutils_intermediates/libutils.so
        ${PROJECT_DIR}/out/target/product/${ANDROID_LUNCH}/obj/SHARED_LIBRARIES/libcutils_intermediates/libcutils.so
        ${PROJECT_DIR}/out/target/product/${ANDROID_LUNCH}/obj/SHARED_LIBRARIES/libz_intermediates/libz.so
        ${PROJECT_DIR}/out/target/product/${ANDROID_LUNCH}/obj/SHARED_LIBRARIES/libc++_intermediates/libc++.so
        ${PROJECT_DIR}/out/target/product/${ANDROID_LUNCH}/obj/SHARED_LIBRARIES/libdl_intermediates/libdl.so
        ${PROJECT_DIR}/out/target/product/${ANDROID_LUNCH}/obj/SHARED_LIBRARIES/libc_intermediates/libc.so
        ${PROJECT_DIR}/out/target/product/${ANDROID_LUNCH}/obj/SHARED_LIBRARIES/libm_intermediates/libm.so
        )