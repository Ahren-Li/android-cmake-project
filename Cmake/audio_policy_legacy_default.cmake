if(ANDROID_LIB_AUDIO_POLICY_LEGACY_DEFAULT)
    return()
endif()
SET(ANDROID_LIB_AUDIO_POLICY_LEGACY_DEFAULT ON)

set(src_dir ${PROJECT_DIR}/hardware/libhardware_legacy/audio)

SET(audio_policy_src
        ${src_dir}/AudioPolicyManagerDefault.cpp
        ${src_dir}/AudioPolicyManagerBase.cpp
        ${src_dir}/AudioPolicyCompatClient.cpp
        ${src_dir}/audio_policy_hal.cpp
        )

add_library(audio_policy.default SHARED ${audio_policy_src})

target_compile_definitions( audio_policy.default PUBLIC  -Wno-unused-parameter )

target_include_directories(audio_policy.default PUBLIC
        ${PROJECT_DIR}/system/media/audio_route/include
        )