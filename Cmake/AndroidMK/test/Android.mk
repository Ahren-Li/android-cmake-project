include $(CLEAR_VARS)

commsrc := common.cpp

LOCAL_CFLAGS +=  -DLILI

ifeq ($(strip ($($(TARGET_BOARD_TEST)))),rk3399)
    LOCAL_CFLAGS +=  -DSF_RK3399
else
    LOCAL_CFLAGS +=  -DSF_RK3288
endif

LOCAL_CFLAGS +=  -DLILIXXX

LOCAL_SRC_FILES := \
	$(commsrc) \
    test.cpp

LOCAL_MODULE := lili_test

LOCAL_SHARED_LIBRARIES := lili_dep
#LOCAL_STATIC_LIBRARIES := libadb

LOCAL_C_INCLUDES += system/extras/ext4_utils
LOCAL_C_INCLUDES += system/core/fs_mgr/include

include $(BUILD_SHARED_LIBRARY)