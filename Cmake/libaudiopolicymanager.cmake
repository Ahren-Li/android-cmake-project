if(ANDROID_LIB_LIBAUDIOPOLICYMANAGER)
    return()
endif()
SET(ANDROID_LIB_LIBAUDIOPOLICYMANAGER ON)

include(libaudiopolicyenginedefault)

set(src_dir ${PROJECT_DIR}/frameworks/av/services/audiopolicy)

SET(libaudiopolicymanager_src
        ${src_dir}/manager/AudioPolicyFactory.cpp
        )

SET(libaudiopolicymanagerdefault_src
        ${src_dir}/managerdefault/AudioPolicyManager.cpp
        )

add_library(libaudiopolicymanager SHARED ${libaudiopolicymanager_src})
add_library(libaudiopolicymanagerdefault SHARED ${libaudiopolicymanagerdefault_src})

target_link_libraries(libaudiopolicymanagerdefault libaudiopolicyenginedefault)

target_compile_definitions( libaudiopolicymanagerdefault PUBLIC  -DBOX_STRATEGY )

target_include_directories(libaudiopolicymanager PUBLIC
        ${PROJECT_DIR}/frameworks/av/services/audiopolicy/common/include
        ${PROJECT_DIR}/frameworks/av/services/audiopolicy/engine/interface
        )
target_include_directories(libaudiopolicymanagerdefault PUBLIC
        ${PROJECT_DIR}/frameworks/av/services/audiopolicy/common/include
        ${PROJECT_DIR}/frameworks/av/services/audiopolicy/engine/interface
        ${PROJECT_DIR}/frameworks/av/services/audiopolicy/utilities
        )