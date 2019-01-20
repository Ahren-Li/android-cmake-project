if(ANDROID_LIB_AUDIOPOLICYCOMPONENTS)
    return()
endif()
SET(ANDROID_LIB_AUDIOPOLICYCOMPONENTS ON)

set(src_dir ${PROJECT_DIR}/frameworks/av/services/audiopolicy/common/managerdefinitions)

SET(libaudiopolicycomponents_src
        ${src_dir}/src/DeviceDescriptor.cpp
        ${src_dir}/src/AudioGain.cpp
        ${src_dir}/src/HwModule.cpp
        ${src_dir}/src/IOProfile.cpp
        ${src_dir}/src/AudioPort.cpp
        ${src_dir}/src/AudioProfile.cpp
        ${src_dir}/src/AudioRoute.cpp
        ${src_dir}/src/AudioPolicyMix.cpp
        ${src_dir}/src/AudioPatch.cpp
        ${src_dir}/src/AudioInputDescriptor.cpp
        ${src_dir}/src/AudioOutputDescriptor.cpp
        ${src_dir}/src/AudioCollections.cpp
        ${src_dir}/src/EffectDescriptor.cpp
        ${src_dir}/src/SoundTriggerSession.cpp
        ${src_dir}/src/SessionRoute.cpp
        ${src_dir}/src/AudioSourceDescriptor.cpp
        ${src_dir}/src/VolumeCurve.cpp
        ${src_dir}/src/TypeConverter.cpp
        ${src_dir}/src/AudioSession.cpp
        )

SET(libaudiopolicycomponents_src ${libaudiopolicycomponents_src}
        ${src_dir}/src/ConfigParsingUtils.cpp
        ${src_dir}/src/StreamDescriptor.cpp
        ${src_dir}/src/Gains.cpp
)

add_library(libaudiopolicycomponents SHARED ${libaudiopolicycomponents_src})


target_compile_definitions( libaudiopolicycomponents PUBLIC  -DBOX_STRATEGY )



target_include_directories(libaudiopolicycomponents PUBLIC
        ${src_dir}/include
        ${PROJECT_DIR}/frameworks/av/services/audiopolicy/common/include
        ${PROJECT_DIR}/frameworks/av/services/audiopolicy
        ${PROJECT_DIR}/frameworks/av/services/audiopolicy/utilities
)