if(ANDROID_LIB_AUDIOPOLICY)
    return()
endif()
SET(ANDROID_LIB_AUDIOPOLICY ON)

include(libaudiopolicycomponents)
include(libaudiopolicymanager)

set(src_dir ${PROJECT_DIR}/frameworks/av/services/audiopolicy)

SET(libaudiopolicyservice_src
        ${src_dir}/service/AudioPolicyService.cpp
        ${src_dir}/service/AudioPolicyEffects.cpp
        )


#SET(libaudiopolicyservice_src $(libaudiopolicyservice_src)
#        ${src_dir}/service/AudioPolicyInterfaceImplLegacy.cpp
#        ${src_dir}/service/AudioPolicyClientImplLegacy.cpp)
SET(libaudiopolicyservice_src ${libaudiopolicyservice_src}
        ${src_dir}/service/AudioPolicyInterfaceImpl.cpp
        ${src_dir}/service/AudioPolicyClientImpl.cpp)

add_library(libaudiopolicyservice SHARED ${libaudiopolicyservice_src} )

target_link_libraries( libaudiopolicyservice libaudiopolicymanager)

#target_compile_definitions( libaudiopolicyservice PUBLIC  -DUSE_LEGACY_AUDIO_POLICY )

target_compile_options(libaudiopolicyservice PUBLIC $<$<COMPILE_LANGUAGE:CXX>:-Wno-unused-parameter>)

target_include_directories(libaudiopolicyservice PUBLIC
        ${PROJECT_DIR}/system/media/audio_route/include
        ${PROJECT_DIR}/frameworks/av/services/audioflinger
        ${PROJECT_DIR}/system/media/audio_utils/include
        ${PROJECT_DIR}/system/media/audio-effects/include
        ${PROJECT_DIR}/frameworks/av/services/audiopolicy/common/include
        ${PROJECT_DIR}/frameworks/av/services/audiopolicy/engine/interface
        ${PROJECT_DIR}/frameworks/av/services/audiopolicy/utilities
        )