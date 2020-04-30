include $(CLEAR_VARS)

LIST_TEST := MK_DEFINE

commsrc := common.cpp
comm := help

LOCAL_CFLAGS += -DLILI -D$(LIST_TEST)_TT

ifneq ($(strip $(TARGET_BOARD_PLATFORM)),rk3399)
    LOCAL_CFLAGS +=  -DSF_RK3288
else
    LOCAL_CFLAGS +=  -DSF_RK3399
endif

ifneq ($(TARGET_BOARD_PLATFORM),rk3399)
    LOCAL_CFLAGS +=  -DNO_FUNC
else
    LOCAL_CFLAGS +=  -DHAVE_FUNC
endif

ifneq ($(filter userdebug eng user,$(TARGET_BUILD_VARIANT)),)
init_options += -DALLOW_LOCAL_PROP_OVERRIDE=1 -DALLOW_DISABLE_SELINUX=1
else
init_options += -DALLOW_LOCAL_PROP_OVERRIDE=0 -DALLOW_DISABLE_SELINUX=0
endif

LOCAL_SRC_FILES := \
	$(commsrc) \
	$(comm)_suffix.cpp \
	$(comm)/common.cpp \
    test.cpp

LOCAL_MODULE := lili_dep

LOCAL_C_INCLUDES += system/extras/ext4_utils
LOCAL_C_INCLUDES += system/core/fs_mgr/include

include $(BUILD_SHARED_LIBRARY)