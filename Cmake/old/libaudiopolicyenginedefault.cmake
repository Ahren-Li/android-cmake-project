if(ANDROID_LIB_AUDIOPOLICYENGINEDEFAULT)
    return()
endif()
SET(ANDROID_LIB_AUDIOPOLICYENGINEDEFAULT ON)

set(src_dir ${PROJECT_DIR}/frameworks/av/services/audiopolicy/enginedefault)

SET(libaudiopolicyenginedefault_src
        ${src_dir}/src/Engine.cpp
        ${src_dir}/src/EngineInstance.cpp
        )

add_library(libaudiopolicyenginedefault SHARED ${libaudiopolicyenginedefault_src})


target_compile_definitions( libaudiopolicyenginedefault PUBLIC  -DBOX_STRATEGY )



target_include_directories(libaudiopolicyenginedefault PUBLIC
        ${src_dir}/include
        ${PROJECT_DIR}/frameworks/av/services/audiopolicy/engine/interface
        ${PROJECT_DIR}/out/target/product/q201/obj/include/hw
        ${PROJECT_DIR}/frameworks/av/services/audiopolicy/common/include
        ${PROJECT_DIR}/frameworks/av/services/audiopolicy/common/managerdefinitions/include
)