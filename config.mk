
# 各个子目录下的 makefile 需要用到这里定义的变量, 通过 export 实现.
# 不要把 BUILD_ROOT 和 BUILD_DIR 弄混淆了

export BUILD_ROOT = $(shell pwd)

# -levent: Libevent
# -lpthread: pthread
# -lssl -lcrypto: openssl
# -lfcgi: fastCGI
# -lhiredis: hiredis
# export LDFLAGS = `pkg-config --libs --cflags hiredis`

# -I/usr/local/include/hiredis: hiredis
export INCLUDE_PATH = $(BUILD_ROOT)/_include

# app目录要位于最下面
BUILD_DIR = $(BUILD_ROOT)/net/ \
			$(BUILD_ROOT)/app/

export DEBUG = true
