if(ANDROID_LIB_SURFACE_FLINGER)
    return()
endif()
SET(ANDROID_LIB_SURFACE_FLINGER ON)

#include(libcutils)
#include(libgui)
#include(libui)
#project(surfaceflinger)

#for surfaceflinger
include_directories(
        "${PROJECT_DIR}/frameworks/native/vulkan/include"
        "${PROJECT_DIR}/external/vulkan-validation-layers/libs/vkjson"
        "${PROJECT_DIR}/hardware/amlogic/gralloc"
        "${PROJECT_DIR}/frameworks/native/services/surfaceflinger"
        "${PROJECT_DIR}/out/target/product/q201/obj/EXECUTABLES/surfaceflinger_intermediates"
        "${PROJECT_DIR}/out/target/product/q201/gen/EXECUTABLES/surfaceflinger_intermediates"
        "${PROJECT_DIR}/external/libcxx/include"
        "${PROJECT_DIR}/external/libcxxabi/include"
)

set(src_dir ${PROJECT_DIR}/frameworks/native/services/surfaceflinger)

set(surfaceflinger_src
        ${src_dir}/Client.cpp
        ${src_dir}/DisplayDevice.cpp
        ${src_dir}/DispSync.cpp
        ${src_dir}/EventControlThread.cpp
        ${src_dir}/EventThread.cpp
        ${src_dir}/FenceTracker.cpp
        ${src_dir}/FrameTracker.cpp
        ${src_dir}/GpuService.cpp
        ${src_dir}/Layer.cpp
        ${src_dir}/LayerDim.cpp
        ${src_dir}/MessageQueue.cpp
        ${src_dir}/MonitoredProducer.cpp
        ${src_dir}/SurfaceFlingerConsumer.cpp
        ${src_dir}/Transform.cpp
        ${src_dir}/DisplayHardware/FramebufferSurface.cpp
        ${src_dir}/DisplayHardware/HWC2.cpp
        ${src_dir}/DisplayHardware/HWC2On1Adapter.cpp
        ${src_dir}/DisplayHardware/PowerHAL.cpp
        ${src_dir}/DisplayHardware/VirtualDisplaySurface.cpp
        ${src_dir}/Effects/Daltonizer.cpp
        ${src_dir}/EventLog/EventLogTags.logtags
        ${src_dir}/EventLog/EventLog.cpp
        ${src_dir}/RenderEngine/Description.cpp
        ${src_dir}/RenderEngine/Mesh.cpp
        ${src_dir}/RenderEngine/Program.cpp
        ${src_dir}/RenderEngine/ProgramCache.cpp
        ${src_dir}/RenderEngine/GLExtensions.cpp
        ${src_dir}/RenderEngine/RenderEngine.cpp
        ${src_dir}/RenderEngine/Texture.cpp
        ${src_dir}/RenderEngine/GLES10RenderEngine.cpp
        ${src_dir}/RenderEngine/GLES11RenderEngine.cpp
        ${src_dir}/RenderEngine/GLES20RenderEngine.cpp
        )

set(surfaceflinger_hwc2_src
        ${src_dir}/SurfaceFlinger.cpp
        ${src_dir}/DisplayHardware/HWComposer.cpp)

add_library(libsurfaceflinger SHARED ${surfaceflinger_src} ${surfaceflinger_hwc2_src})

target_compile_definitions( libsurfaceflinger PUBLIC  -DUSE_HWC2)
target_compile_definitions( libsurfaceflinger PUBLIC  -DLOG_TAG=\"SurfaceFlinger\")

target_compile_definitions( libsurfaceflinger PUBLIC  -DGL_GLEXT_PROTOTYPES -DEGL_EGLEXT_PROTOTYPES)
target_compile_definitions( libsurfaceflinger PUBLIC  -DGL_GLEXT_PROTOTYPES -DEGL_EGLEXT_PROTOTYPES)
target_compile_definitions( libsurfaceflinger PUBLIC  -DNUM_FRAMEBUFFER_SURFACE_BUFFERS=3)
target_compile_definitions( libsurfaceflinger PUBLIC  -DVSYNC_EVENT_PHASE_OFFSET_NS=1000000)
target_compile_definitions( libsurfaceflinger PUBLIC  -DSF_VSYNC_EVENT_PHASE_OFFSET_NS=1000000)
target_compile_definitions( libsurfaceflinger PUBLIC  -DPRESENT_TIME_OFFSET_FROM_VSYNC_NS=0)
target_compile_definitions( libsurfaceflinger PUBLIC  -DMAX_VIRTUAL_DISPLAY_DIMENSION=0)
target_compile_definitions( libsurfaceflinger PUBLIC  -DUSE_AML_HW_ACTIVE_MODE)

#amlogic
target_compile_definitions( libsurfaceflinger PUBLIC  -DUSE_AML_HW_POST_SCALE)

ADD_DEPENDENCIES(libsurfaceflinger libcutils)

