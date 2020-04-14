# COMBO_GLOBAL_CFLAGS COMBO_GLOBAL_CPPFLAGS
# COMMON_GLOBAL_CFLAGS COMMON_GLOBAL_CPPFLAGS
# TARGET_ERROR_FLAGS TARGET_RELEASE_CFLAGS
# CLANG_CONFIG_EXTRA_CFLAGS CLANG_CONFIG_EXTRA_CPPFLAGS
# COMMON_TARGET_RTTI_FLAG COMMON_TARGET_CFLAGS
# COMMON_TARGET_GLOBAL_CONLYFLAGS COMMON_TARGET_GLOBAL_CPPFLAGS
# COMMON_TARGET_CFLAGS_NO_OVERRIDE

set(COMBO_GLOBAL_CFLAGS
        -fno-exceptions
        -Wno-multichar)
if (ANDROID_SYSROOT_ABI STREQUAL arm)
    list(APPEND COMBO_GLOBAL_CFLAGS
            -msoft-float)
else()
    list(APPEND COMBO_GLOBAL_CFLAGS -fno-strict-aliasing)
    list(APPEND COMBO_GLOBAL_CFLAGS
            -Werror=pointer-to-int-cast
            -Werror=int-to-pointer-cast
            -Werror=implicit-function-declaration)
endif ()

list(APPEND COMBO_GLOBAL_CFLAGS
        -ffunction-sections
        -fdata-sections
        -funwind-tables
        -fstack-protector-strong
        -Wa,--noexecstack
        -Werror=format-security
        -D_FORTIFY_SOURCE=2
        -fno-short-enums
        -no-canonical-prefixes)

set(COMBO_GLOBAL_CPPFLAGS -fvisibility-inlines-hidden)

## mach cpu
if(ANDROID_ABI STREQUAL arm64-v8a)
    include(arm64/armv8-a.cmake)
elseif(ANDROID_ABI STREQUAL "armeabi-v7a with NEON")
    include(arm/armv7-a-neon.cmake)
elseif(ANDROID_ABI STREQUAL armeabi-v7a)
    include(arm/armv7-a.cmake)
endif()

set(COMMON_GLOBAL_CFLAGS
        -DANDROID
        -fmessage-length=0
        -W -Wall -Wno-unused
        -Winit-self
        -Wpointer-arith)

set(COMMON_GLOBAL_CPPFLAGS -Wsign-promo)

set(TARGET_ERROR_FLAGS
        -Werror=return-type
        -Werror=non-virtual-dtor
        -Werror=address
        -Werror=sequence-point
        -Werror=date-time)

set(TARGET_RELEASE_CFLAGS
        -DNDEBUG -UDEBUG
        -O2 -g
        -Wstrict-aliasing=2)

##############################################################################
# clang
set(CLANG_CONFIG_EXTRA_CFLAGS -D__compiler_offsetof=__builtin_offsetof )
# Help catch common 32/64-bit errors.
list(APPEND CLANG_CONFIG_EXTRA_CFLAGS -Werror=int-conversion)
# Disable overly aggressive warning for macros defined with a leading underscore
# This used to happen in AndroidConfig.h, which was included everywhere.
list(APPEND CLANG_CONFIG_EXTRA_CFLAGS -Wno-reserved-id-macro)
# Disable overly aggressive warning for format strings.
# Bug: 20148343
list(APPEND CLANG_CONFIG_EXTRA_CFLAGS -Wno-format-pedantic)
# Workaround for ccache with clang.
# See http://petereisentraut.blogspot.com/2011/05/ccache-and-clang.html.
list(APPEND CLANG_CONFIG_EXTRA_CFLAGS -Wno-unused-command-line-argument)
list(APPEND CLANG_CONFIG_EXTRA_CFLAGS -nostdlibinc)
list(APPEND CLANG_CONFIG_EXTRA_CFLAGS
        "-target ${ANDROID_TOOLCHAIN_NAME}"
        "-B${ANDROID_TOOLCHAIN_ROOT}/bin")

set(CLANG_CONFIG_EXTRA_CPPFLAGS -Wno-inconsistent-missing-override)

set(COMMON_TARGET_RTTI_FLAG -fno-rtti)
set(COMMON_TARGET_CFLAGS -fpie -D_USING_LIBCXX)
set(COMMON_TARGET_GLOBAL_CONLYFLAGS -std=gnu99)
set(COMMON_TARGET_GLOBAL_CPPFLAGS -std=gnu++14)
set(COMMON_TARGET_CFLAGS_NO_OVERRIDE
        -Werror=int-to-pointer-cast
        -Werror=pointer-to-int-cast
        -Werror=address-of-temporary
        -Werror=null-dereference
        -Werror=return-type)

#######################################################################
if(ANDROID_SYSROOT_ABI STREQUAL arm64)
    set(ANDROID_LINKER /system/bin/linker64)
else()
    set(ANDROID_LINKER /system/bin/linker)
endif()
set(ANDROID_GLOBAL_LD_DIRS
        -L${ANDROID_TARGET_OUT_DIR}/${ANDROID_OBJ_DIR}/${ANDROID_LIBDIR_NAME})
set(ANDROID_CRTBEGIN_DYNAMIC_O ${ANDROID_GLOBAL_LD_DIRS}/crtbegin_dynamic.o)
set(ANDROID_CRTEND_O ${ANDROID_GLOBAL_LD_DIRS}/crtend_android.o)

#######################################################################
set(ANDROID_COMPILER_FLAGS
        ${COMBO_GLOBAL_CFLAGS}
        ${COMMON_GLOBAL_CFLAGS}
        ${TARGET_ERROR_FLAGS}
        ${TARGET_RELEASE_CFLAGS}
        ${CLANG_CONFIG_EXTRA_CFLAGS}
        ${COMMON_TARGET_RTTI_FLAG}
        ${COMMON_TARGET_CFLAGS}
        ${COMMON_TARGET_GLOBAL_CONLYFLAGS}
        ${COMMON_TARGET_CFLAGS_NO_OVERRIDE}
        )

set(ANDROID_COMPILER_FLAGS_CXX
        ${COMBO_GLOBAL_CFLAGS}
        ${COMBO_GLOBAL_CPPFLAGS}
        ${COMMON_GLOBAL_CFLAGS}
        ${COMMON_GLOBAL_CPPFLAGS}
        ${TARGET_ERROR_FLAGS}
        ${TARGET_RELEASE_CFLAGS}
        ${CLANG_CONFIG_EXTRA_CFLAGS}
        ${CLANG_CONFIG_EXTRA_CPPFLAGS}
        ${COMMON_TARGET_RTTI_FLAG}
        ${COMMON_TARGET_CFLAGS}
        ${COMMON_TARGET_GLOBAL_CPPFLAGS}
        ${COMMON_TARGET_CFLAGS_NO_OVERRIDE}
        )