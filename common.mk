
# OBJS 和 LINK_OBJ 的关系:
#   OBJS: 当前子目录下的文件生成的.o文件
#   LINK_OBJ: 执行到某个目录下的makefile时, app/link_obj/ 目录下所有的.o文件, 再加上 OBJS.

ifeq ($(DEBUG),true)
CC = gcc -g
VERSION = debug
else
cc = gcc
VERSION = release
endif

EXT = c

SRCS = $(wildcard *.$(EXT))
OBJS = $(SRCS:.$(EXT)=.o)
DEPS = $(SRCS:.$(EXT)=.d)

# := 立刻展开
BIN := $(addprefix $(BUILD_ROOT)/, $(BIN))

LINK_OBJ_DIR = $(BUILD_ROOT)/app/link_obj
DEP_DIR = $(BUILD_ROOT)/app/dep

$(shell mkdir -p $(LINK_OBJ_DIR))
$(shell mkdir -p $(DEP_DIR))

# 将各个子目录下的 .o 文件和 .d 文件都集中放在 app/link_obj/ 和 app/dep/ 目录下
OBJS := $(addprefix $(LINK_OBJ_DIR)/,$(OBJS))
DEPS := $(addprefix $(DEP_DIR)/, $(DEPS))

LINK_OBJ = $(wildcard $(LINK_OBJ_DIR)/*.o)
LINK_OBJ += $(OBJS)

.PHONY: all
all:$(DEPS) $(OBJS) $(BIN)

ifneq ("$(wildcard $(DEPS))","")
include $(DEPS)
endif

$(BIN):$(LINK_OBJ)
	$(CC) -o $@ $^ $(LDFLAGS)

# 实现当前目录下的 .c 文件 生成 .o 文件
$(LINK_OBJ_DIR)/%.o:%.$(EXT)
	$(CC) $(INCLUDE_PATH) -o $@ -c $(filter %.$(EXT),$^) 

# 要为.d文件添加前缀路径
$(DEP_DIR)/%.d:%.$(EXT)
	echo -n $(LINK_OBJ_DIR)/ > $@
	$(CC) $(INCLUDE_PATH) -MM $^ >> $@
