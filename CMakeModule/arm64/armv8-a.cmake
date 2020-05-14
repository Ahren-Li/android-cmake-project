set(ARCH_VARIANT_CLFAGS -march=armv8-a)
set(ARCH_VARIANT_LDLFAGS
		-Wl,-m,aarch64_elf64_le_vec
		-Wl,--hash-style=gnu
		-fuse-ld=gold
		-Wl,--icf=safe
		)
if(ANDROID_CPU_VARIANT MATCHES "^(cortex-a53|cortex-a55|cortex-a75)")
	list(APPEND ARCH_VARIANT_CLFAGS -mcpu=cortex-a53)
elseif(ANDROID_CPU_VARIANT MATCHES "kryo")
	list(APPEND ARCH_VARIANT_CLFAGS -mcpu=cortex-a57)
elseif(ANDROID_CPU_VARIANT MATCHES "exynos-m1")
	list(APPEND ARCH_VARIANT_CLFAGS -mcpu=exynos-m1)
elseif(ANDROID_CPU_VARIANT MATCHES "exynos-m2")
	list(APPEND ARCH_VARIANT_CLFAGS -mcpu=exynos-m2)
else()
	list(APPEND ARCH_VARIANT_CLFAGS -mcpu=cortex-a53)
endif()

list(APPEND ARCH_VARIANT_LDLFAGS -Wl,--fix-cortex-a53-843419)