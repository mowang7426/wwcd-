TARGET := iphone:clang:latest:16.0
INSTALL_TARGET_PROCESSES = SpringBoard PosterBoard
# 如果你是 Rootless 越狱 (如 Dopamine)，需要取消下面这行的注释
# THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = WWDC22PosterEnabler

WWDC22PosterEnabler_FILES = Tweak.x
WWDC22PosterEnabler_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
