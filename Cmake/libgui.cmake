if(ANDROID_LIB_GUI)
    return()
endif()
SET(ANDROID_LIB_GUI ON)

set(src_dir ${PROJECT_DIR}/frameworks/native/libs/gui)

SET(libgui_src
        ${src_dir}/IGraphicBufferConsumer.cpp
        ${src_dir}/IConsumerListener.cpp
        ${src_dir}/BitTube.cpp
        ${src_dir}/BufferItem.cpp
        ${src_dir}/BufferItemConsumer.cpp
        ${src_dir}/BufferQueue.cpp
        ${src_dir}/BufferQueueConsumer.cpp
        ${src_dir}/BufferQueueCore.cpp
        ${src_dir}/BufferQueueProducer.cpp
        ${src_dir}/BufferSlot.cpp
        ${src_dir}/ConsumerBase.cpp
        ${src_dir}/CpuConsumer.cpp
        ${src_dir}/DisplayEventReceiver.cpp
        ${src_dir}/GLConsumer.cpp
        ${src_dir}/GraphicBufferAlloc.cpp
        ${src_dir}/GraphicsEnv.cpp
        ${src_dir}/GuiConfig.cpp
        ${src_dir}/IDisplayEventConnection.cpp
        ${src_dir}/IGraphicBufferAlloc.cpp
        ${src_dir}/IGraphicBufferProducer.cpp
        ${src_dir}/IProducerListener.cpp
        ${src_dir}/ISensorEventConnection.cpp
        ${src_dir}/ISensorServer.cpp
        ${src_dir}/ISurfaceComposer.cpp
        ${src_dir}/ISurfaceComposerClient.cpp
        ${src_dir}/LayerState.cpp
        ${src_dir}/OccupancyTracker.cpp
        ${src_dir}/Sensor.cpp
        ${src_dir}/SensorEventQueue.cpp
        ${src_dir}/SensorManager.cpp
        ${src_dir}/StreamSplitter.cpp
        ${src_dir}/Surface.cpp
        ${src_dir}/SurfaceControl.cpp
        ${src_dir}/SurfaceComposerClient.cpp
        ${src_dir}/SyncFeatures.cpp )


add_library(libgui ${libgui_src} )
target_include_directories(libgui PUBLIC ${PROJECT_DIR}/hardware/amlogic/gralloc)
target_compile_options(libgui PUBLIC $<$<COMPILE_LANGUAGE:CXX>:-std=c++1y -Weverything -Werror>)

# The static constructors and destructors in this library have not been noted to
# introduce significant overheads
target_compile_options(libgui PUBLIC $<$<COMPILE_LANGUAGE:CXX>:-Wno-exit-time-destructors -Wno-global-constructors>)

# We only care about compiling as C++14
target_compile_options(libgui PUBLIC $<$<COMPILE_LANGUAGE:CXX>:-Wno-c++98-compat-pedantic>)

# We don't need to enumerate every case in a switch as long as a default case
# is present
target_compile_options(libgui PUBLIC $<$<COMPILE_LANGUAGE:CXX>:-Wno-switch-enum>)

# Allow calling variadic macros without a __VA_ARGS__ list
target_compile_options(libgui PUBLIC $<$<COMPILE_LANGUAGE:CXX>:-Wno-gnu-zero-variadic-macro-arguments>)

# Don't warn about struct padding
target_compile_options(libgui PUBLIC $<$<COMPILE_LANGUAGE:CXX>:-Wno-padded>)

target_compile_definitions( libgui PUBLIC  -DDEBUG_ONLY_CODE=1)

