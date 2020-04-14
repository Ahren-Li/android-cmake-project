# ###########################arm-c/cpp
# -I
set(PRIVATE_C_INCLUDES
        device/htc/m8-common/include
        android-test/test
        /Misc/CyanogenMod/out/target/product/m8/obj/EXECUTABLES/test_intermediates
        /Misc/CyanogenMod/out/target/product/m8/gen/EXECUTABLES/test_intermediates
        libnativehelper/include/nativehelper)
# $(shell cat /Misc/CyanogenMod/out/target/product/m8/obj/EXECUTABLES/test_intermediates/import_include)

# system filter-out PRIVATE_C_INCLUDES
set(PRIVATE_TARGET_PROJECT_INCLUDES
        system/core/include
        system/media/audio/include
        hardware/libhardware/include
        hardware/libhardware_legacy/include
        libnativehelper/include
        frameworks/native/include
        frameworks/native/opengl/include
        frameworks/av/include
        frameworks/base/include
        hardware/ril-caf/include
        /Misc/CyanogenMod/out/target/product/m8/obj/include)

set(PRIVATE_TARGET_C_INCLUDES
        bionic/libc/arch-arm/include
        bionic/libc/include
        bionic/libc/kernel/uapi
        bionic/libc/kernel/common
        bionic/libc/kernel/uapi/asm-arm
        bionic/libm/include
        bionic/libm/include/arm)

# flag
set(PRIVATE_TARGET_GLOBAL_CFLAGS
        -fno-exceptions
        -Wno-multichar
        -msoft-float
        -ffunction-sections
        -fdata-sections
        -funwind-tables
        -fstack-protector-strong
        -Wa,--noexecstack
        -Werror=format-security
        -D_FORTIFY_SOURCE=2
        -fno-short-enums
        -no-canonical-prefixes
        -mcpu=cortex-a15
        -mfpu=neon-vfpv4
        -D__ARM_FEATURE_LPAE=1
        -mfloat-abi=softfp
        -DQCOM_HARDWARE -DQCOM_BSP -DQTI_BSP -DANDROID
        -fmessage-length=0
        -W -Wall -Wno-unused -Winit-self -Wpointer-arith -Werror=return-type
        -Werror=non-virtual-dtor -Werror=address -Werror=sequence-point
        -Werror=date-time -DNDEBUG -g -Wstrict-aliasing=2
        -DNDEBUG -UDEBUG  -D__compiler_offsetof=__builtin_offsetof
        -Werror=int-conversion -Wno-reserved-id-macro -Wno-format-pedantic
        -Wno-unused-command-line-argument
        -fcolor-diagnostics -nostdlibinc
        -mcpu=krait -mfpu=neon-vfpv4
        -target arm-linux-androideabi
        -target arm-linux-androideabi
        -Bprebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9/arm-linux-androideabi/bin)

#cpp
set(PRIVATE_TARGET_GLOBAL_CPPFLAGS
        -fvisibility-inlines-hidden
        -DQCOM_HARDWARE -DQCOM_BSP -DQTI_BSP
        -Wsign-promo  -Wno-inconsistent-missing-override
        -nostdlibinc  -target arm-linux-androideabi)
#arm
set(PRIVATE_ARM_CFLAGS
        -mthumb -Os -fomit-frame-pointer
        -fno-strict-aliasing)
# cpp
set(PRIVATE_RTTI_FLAG -fno-rtti)

set(PRIVATE_CFLAGS -fpie -D_USING_LIBCXX)
# c
set(PRIVATE_TARGET_GLOBAL_CONLYFLAGS -std=gnu99)
# cpp
set(PRIVATE_CPPFLAGS -std=gnu++14)

set(PRIVATE_DEBUG_CFLAGS )
set(PRIVATE_CFLAGS_NO_OVERRIDE
        -Werror=int-to-pointer-cast
        -Werror=pointer-to-int-cast
        -Werror=address-of-temporary
        -Werror=null-dereference
        -Werror=return-type)
#cpp
set(PRIVATE_CPPFLAGS_NO_OVERRIDE )

# link
set(PRIVATE_LINKER
        /system/bin/linker)
set(PRIVATE_TARGET_GLOBAL_LD_DIRS
        -L/Misc/CyanogenMod/out/target/product/m8/obj/lib)
set(PRIVATE_TARGET_OUT_INTERMEDIATE_LIBRARIES
        /Misc/CyanogenMod/out/target/product/m8/obj/lib)
set(PRIVATE_TARGET_CRTBEGIN_DYNAMIC_O
        /Misc/CyanogenMod/out/target/product/m8/obj/lib/crtbegin_dynamic.o)
set(PRIVATE_ALL_WHOLE_STATIC_LIBRARIES )
set(PRIVATE_GROUP_STATIC_LIBRARIES )
set(PRIVATE_ALL_STATIC_LIBRARIES
        /Misc/CyanogenMod/out/target/product/m8/obj/STATIC_LIBRARIES/libunwind_llvm_intermediates/libunwind_llvm.a
        /Misc/CyanogenMod/out/target/product/m8/obj/STATIC_LIBRARIES/libcompiler_rt-extras_intermediates/libcompiler_rt-extras.a)
set(PRIVATE_GROUP_STATIC_LIBRARIES )
set(NATIVE_COVERAGE )
set(PRIVATE_TARGET_COVERAGE_LIB
        prebuilts/clang/host/linux-x86/clang-2690385/bin/../lib64/clang/3.8/lib/linux//libclang_rt.profile-arm-android.a)
set(PRIVATE_TARGET_LIBATOMIC
        prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9/bin/../lib/gcc/arm-linux-androideabi/4.9/../../../../arm-linux-androideabi/lib/libatomic.a)
set(PRIVATE_TARGET_LIBGCC
        prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9/bin/../lib/gcc/arm-linux-androideabi/4.9/libgcc.a)
set(PRIVATE_ALL_SHARED_LIBRARIES
        /Misc/CyanogenMod/out/target/product/m8/obj/lib/libc++.so
        /Misc/CyanogenMod/out/target/product/m8/obj/lib/libdl.so
        /Misc/CyanogenMod/out/target/product/m8/obj/lib/libc.so
        /Misc/CyanogenMod/out/target/product/m8/obj/lib/libm.so)
set(PRIVATE_TARGET_GLOBAL_LDFLAGS
        -Wl,-z,noexecstack
        -Wl,-z,relro
        -Wl,-z,now
        -Wl,--build-id=md5
        -Wl,--warn-shared-textrel
        -Wl,--fatal-warnings
        -Wl,--icf=safe
        -Wl,--hash-style=gnu
        -Wl,--no-undefined-version
        -Wl,--no-fix-cortex-a8
        -target arm-linux-androideabi
        -Bprebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9/arm-linux-androideabi/bin)
set(PRIVATE_LDFLAGS
        -Wl,--exclude-libs,libunwind_llvm.a -Wl,--no-undefined)
set(PRIVATE_TARGET_CRTEND_O
        /Misc/CyanogenMod/out/target/product/m8/obj/lib/crtend_android.o)
set(PRIVATE_LDLIBS )