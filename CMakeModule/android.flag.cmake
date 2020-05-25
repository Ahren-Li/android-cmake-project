
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

## mach cpu
if(ANDROID_ABI STREQUAL arm64-v8a)
    include(${CMAKE_CURRENT_LIST_DIR}/arm64/armv8-a.cmake)
elseif(ANDROID_ABI STREQUAL "arm64-v8a2")
    include(${CMAKE_CURRENT_LIST_DIR}/arm64/armv8-2a.cmake)
elseif(ANDROID_ABI STREQUAL "armeabi-v7a with NEON")
    include(${CMAKE_CURRENT_LIST_DIR}/arm/armv7-a-neon.cmake)
elseif(ANDROID_ABI STREQUAL armeabi-v7a)
    include(${CMAKE_CURRENT_LIST_DIR}/arm/armv7-a.cmake)
endif()

list(APPEND COMBO_GLOBAL_CFLAGS
        -ffunction-sections
        -fdata-sections
        -funwind-tables
        -fstack-protector-strong
        -Wa,--noexecstack
        -Werror=format-security
        -D_FORTIFY_SOURCE=2
        -fno-short-enums
        -no-canonical-prefixes
        ${ARCH_VARIANT_CLFAGS}
        )

set(COMBO_GLOBAL_CPPFLAGS -fvisibility-inlines-hidden)

set(COMMON_GLOBAL_CFLAGS
        -DANDROID
        -fmessage-length=0
        -W -Wall -Wno-unused
        -Winit-self
        -Wpointer-arith)

set(COMMON_GLOBAL_CPPFLAGS
        -Wsign-promo
        -Wno-inconsistent-missing-override
        -Wno-null-dereference
        -D_LIBCPP_ENABLE_THREAD_SAFETY_ANNOTATIONS
        -Wno-thread-safety-negative
        -Wno-gnu-include-next)

set(TARGET_ERROR_FLAGS
        -Werror=return-type
        -Werror=non-virtual-dtor
        -Werror=address
        -Werror=sequence-point
        -Werror=date-time)

set(TARGET_RELEASE_CFLAGS
        -DNDEBUG -UDEBUG
        -O2 -g
        -Wno-strict-aliasing
        -fno-exceptions)

set(TARGET_DEBUG_CFLAGS
        -DNDEBUG -UDEBUG
        -O0 -g
        -Wno-strict-aliasing
        -fno-exceptions
        -fno-limit-debug-info
        )

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
list(APPEND CLANG_CONFIG_EXTRA_CFLAGS -Wno-expansion-to-defined)
list(APPEND CLANG_CONFIG_EXTRA_CFLAGS -ffunction-sections)
list(APPEND CLANG_CONFIG_EXTRA_CFLAGS -fdata-sections)
list(APPEND CLANG_CONFIG_EXTRA_CFLAGS -fno-short-enums -funwind-tables -fstack-protector-strong)
list(APPEND CLANG_CONFIG_EXTRA_CFLAGS -fdebug-prefix-map=${PROJECT_DIR}/=)

list(APPEND CLANG_CONFIG_EXTRA_CFLAGS -nostdlibinc)
list(APPEND CLANG_CONFIG_EXTRA_CFLAGS
        "-target ${ANDROID_TOOLCHAIN_NAME}"
        "-B${ANDROID_TOOLCHAIN_ROOT}/bin")

set(CLANG_CONFIG_EXTRA_CPPFLAGS -Wno-inconsistent-missing-override)

set(COMMON_TARGET_RTTI_FLAG -fno-rtti)
set(COMMON_TARGET_CFLAGS -fpie -D_USING_LIBCXX -DANDROID_STRICT)
set(COMMON_TARGET_GLOBAL_CONLYFLAGS -std=gnu99)
set(COMMON_TARGET_GLOBAL_CPPFLAGS -std=gnu++14)
set(COMMON_TARGET_CFLAGS_NO_OVERRIDE
        -Werror=int-to-pointer-cast
        -Werror=pointer-to-int-cast
        -Werror=address-of-temporary
        -Werror=null-dereference
        -Werror=return-type
        -Wno-tautological-constant-compare
        -Wno-null-pointer-arithmetic
        -Wno-enum-compare -Wno-enum-compare-switch)

#######################################################################
if(ANDROID_SYSROOT_ABI STREQUAL arm64)
    set(ANDROID_LINKER /system/bin/linker64)
else()
    set(ANDROID_LINKER /system/bin/linker)
endif()
set(ANDROID_GLOBAL_LD_DIRS ${ANDROID_TARGET_OUT_DIR}/${ANDROID_OBJ_DIR}/lib)
set(ANDROID_GLOBAL_EXE_LINK_FLAGS
        -pie
        -nostdlib
        -Bdynamic
        -Wl,-dynamic-linker,${ANDROID_LINKER}
        -Wl,--gc-sections
        -Wl,-z,nocopyreloc
        -Wl,-rpath-link=${ANDROID_GLOBAL_LD_DIRS}
        -L${ANDROID_GLOBAL_LD_DIRS}
        )
set(ANDROID_GLOBAL_SHARED_LINK_FLAGS
        -shared -nostdlib -Wl,--gc-sections
        -Wl,-rpath-link=${ANDROID_GLOBAL_LD_DIRS}
        -L${ANDROID_GLOBAL_LD_DIRS}
        )
set(ANDROID_CRTBEGIN_DYNAMIC_O ${ANDROID_GLOBAL_LD_DIRS}/crtbegin_dynamic.o)
set(ANDROID_CRTEND_O ${ANDROID_GLOBAL_LD_DIRS}/crtend_android.o)
set(ANDROID_CRTBEGIN_SO ${ANDROID_GLOBAL_LD_DIRS}/crtbegin_so.o)
set(ANDROID_CRTEND_SO ${ANDROID_GLOBAL_LD_DIRS}/crtend_so.o)
staticLibDir(clang_rt.ubsan_minimal-aarch64-android clang_rt_static_lib)
staticLibDir(compiler_rt-extras compiler_rt_static_lib)
staticLibDir(atomic atomic_static_lib)
staticLibDir(gcc gcc_static_lib)

set(ANDROID_NEED_STATIC_LIBRARIES ${compiler_rt_static_lib})
if(${ANDROID_SDK_VERSION} GREATER_EQUAL 28)
    list(APPEND ANDROID_NEED_STATIC_LIBRARIES ${clang_rt_static_lib})
endif()
set(ANDROID_ATOMIC_STATIC_LIBRARIES ${atomic_static_lib})
set(ANDROID_GCC_STATIC_LIBRARIES ${gcc_static_lib})
set(ANDROID_NEED_SHARED_LIBRARIES -lc++ -lc -lm -ldl)
set(ANDROID_GLOBAL_LDFLAGS
        -Wl,-z,noexecstack
        -Wl,-z,relro
        -Wl,-z,now
        -Wl,--build-id=md5
        -Wl,--warn-shared-textrel
        -Wl,--fatal-warnings
        -Wl,--no-undefined-version
        ${ARCH_VARIANT_LDLFAGS}
        -target ${ANDROID_TOOLCHAIN_NAME}
        -B${ANDROID_TOOLCHAIN_ROOT}/bin
        )
set(ANDROID_LDFLAGS
        -Wl,--exclude-libs,libclang_rt.ubsan_minimal-aarch64-android.a
        -Wl,--no-undefined)

#######################################################################
set(ANDROID_COMPILER_FLAGS
        ${COMBO_GLOBAL_CFLAGS}
        ${COMMON_GLOBAL_CFLAGS}
        ${TARGET_ERROR_FLAGS}
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
        ${CLANG_CONFIG_EXTRA_CFLAGS}
        ${CLANG_CONFIG_EXTRA_CPPFLAGS}
        ${COMMON_TARGET_RTTI_FLAG}
        ${COMMON_TARGET_CFLAGS}
        ${COMMON_TARGET_GLOBAL_CPPFLAGS}
        ${COMMON_TARGET_CFLAGS_NO_OVERRIDE}
        )

set(ANDROID_COMPILER_FLAGS_RELEASE ${TARGET_RELEASE_CFLAGS})
set(ANDROID_COMPILER_FLAGS_DEBUG ${TARGET_DEBUG_CFLAGS})

set(ANDROID_LINKER_FLAGS_EXE
        ${ANDROID_GLOBAL_EXE_LINK_FLAGS}
        ${ANDROID_CRTBEGIN_DYNAMIC_O}
        )
set(ANDROID_LINKER_FLAGS_SHARED
        ${ANDROID_GLOBAL_SHARED_LINK_FLAGS}
        ${ANDROID_CRTBEGIN_SO}
        )
set(ANDROID_LDFLAGS_EXE
        -Wl,--no-whole-archive
        ${ANDROID_NEED_STATIC_LIBRARIES}
        ${ANDROID_ATOMIC_STATIC_LIBRARIES}
        ${ANDROID_GCC_STATIC_LIBRARIES}
        ${ANDROID_GLOBAL_LDFLAGS}
        ${ANDROID_LDFLAGS}
        ${ANDROID_NEED_SHARED_LIBRARIES}
        )
