if(ANDROID_LIB_ROCKCHIP_AUDIO)
    return()
endif()
SET(ANDROID_LIB_ROCKCHIP_AUDIO ON)

set(src_dir ${PROJECT_DIR}/hardware/rockchip/audio/tinyalsa_hal)

SET(audio_src
        ${src_dir}/audio_hw.c
        ${src_dir}/alsa_route.c
        ${src_dir}/alsa_mixer.c
        ${src_dir}/audio_hw_hdmi.c
        )

add_library(audio.primary.rk30board SHARED ${audio_src})

target_compile_definitions( audio.primary.rk30board PUBLIC  -DBOX_HAL -DRK3399 )

target_include_directories(audio.primary.rk30board PUBLIC
        ${PROJECT_DIR}/external/tinyalsa/include
        ${PROJECT_DIR}/system/media/audio_utils/include
        ${PROJECT_DIR}/system/media/audio_route/include
        ${PROJECT_DIR}/external/speex/include
        ${PROJECT_DIR}/hardware/rockchip/audio/tinyalsa_hal
        )