if(ANDROID_LIB_BINDER)
    return()
endif()
SET(ANDROID_LIB_BINDER ON)

set(src_dir ${PROJECT_DIR}/frameworks/native/libs/binder)

SET(binder_src
    ${src_dir}/AppOpsManager.cpp
    ${src_dir}/Binder.cpp
    ${src_dir}/BpBinder.cpp
    ${src_dir}/BufferedTextOutput.cpp
    ${src_dir}/Debug.cpp
    ${src_dir}/IAppOpsCallback.cpp
    ${src_dir}/IAppOpsService.cpp
    ${src_dir}/IBatteryStats.cpp
    ${src_dir}/IInterface.cpp
    ${src_dir}/IMediaResourceMonitor.cpp
    ${src_dir}/IMemory.cpp
    ${src_dir}/IPCThreadState.cpp
    ${src_dir}/IPermissionController.cpp
    ${src_dir}/IProcessInfoService.cpp
    ${src_dir}/IResultReceiver.cpp
    ${src_dir}/IServiceManager.cpp
    ${src_dir}/MemoryBase.cpp
    ${src_dir}/MemoryDealer.cpp
    ${src_dir}/MemoryHeapBase.cpp
    ${src_dir}/Parcel.cpp
    ${src_dir}/PermissionCache.cpp
    ${src_dir}/PersistableBundle.cpp
    ${src_dir}/ProcessInfoService.cpp
    ${src_dir}/ProcessState.cpp
    ${src_dir}/Static.cpp
    ${src_dir}/Status.cpp
    ${src_dir}/TextOutput.cpp
        )


add_library(libbinder SHARED ${binder_src})


