
set(ARCH_VARIANT_CLFAGS
        -march=armv7-a
        -mfloat-abi=softfp
        )
if(ANDROID_CPU_VARIANT STREQUAL "cortex-a7")
  list(APPEND ARCH_VARIANT_CLFAGS
          -mcpu=cortex-a7
          -mfpu=neon-vfpv4
          -D__ARM_FEATURE_LPAE=1
          )
elseif(ANDROID_CPU_VARIANT STREQUAL "cortex-a8")
  list(APPEND ARCH_VARIANT_CLFAGS
          -mcpu=cortex-a8
          )
elseif(ANDROID_CPU_VARIANT MATCHES "^(cortex-a15|krait)")
  list(APPEND ARCH_VARIANT_CLFAGS
          -mcpu=cortex-a15
          -mfpu=neon-vfpv4
          -D__ARM_FEATURE_LPAE=1
          )
elseif(ANDROID_CPU_VARIANT MATCHES "^(cortex-a53|cortex-a53.57|cortex-a55|cortex-a75|kryo)")
  list(APPEND ARCH_VARIANT_CLFAGS
          -mcpu=cortex-a53
          -mfpu=neon-fp-armv8
          -D__ARM_FEATURE_LPAE=1
          )
else()
  list(APPEND ARCH_VARIANT_CLFAGS
          -mcpu=cortex-a7
          -mfpu=neon
          )
endif()

if(ANDROID_ARM_MODE STREQUAL thumb)
  list(APPEND ARCH_VARIANT_CLFAGS
          -mthumb -Os
          -fomit-frame-pointer
          )
else()
  list(APPEND ARCH_VARIANT_CLFAGS
          -marm
          -fstrict-aliasing
          )
endif()

if(ANDROID_CPU_VARIANT STREQUAL "cortex-a8")
  set(ARCH_VARIANT_LDLFAGS -Wl,--fix-cortex-a8)
else()
  set(ARCH_VARIANT_LDLFAGS -Wl,--no-fix-cortex-a8)
endif()

list(APPEND ARCH_VARIANT_LDLFAGS
        -Wl,--icf=safe
        -Wl,--hash-style=gnu
        -Wl,-m,armelf
        )