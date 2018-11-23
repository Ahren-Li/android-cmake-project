if(ANDROID_LIB_ROCKCHIP_DRMSERVICE)
    return()
endif()
SET(ANDROID_LIB_ROCKCHIP_DRMSERVICE ON)

set(src_dir ${PROJECT_DIR}/system/core/drmservice)

SET(drmservice_src
        ${src_dir}/drmservice.c
        )

add_library(rockchip.drmservice SHARED ${drmservice_src})

#target_compile_definitions( audio.primary.rk30board PUBLIC  -DBOX_HAL -DRK3399 )

#target_include_directories(audio.primary.rk30board PUBLIC
#        ${PROJECT_DIR}/external/tinyalsa/include
#        ${PROJECT_DIR}/system/media/audio_utils/include
#        ${PROJECT_DIR}/system/media/audio_route/include
#        ${PROJECT_DIR}/external/speex/include
#        ${PROJECT_DIR}/hardware/rockchip/audio/tinyalsa_hal
#        )