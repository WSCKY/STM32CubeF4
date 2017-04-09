BUILD ?= $(shell pwd)/../../Build/HALDriver

# source list
SRCS = $(wildcard Src/*.c)

OBJS = $(addprefix $(BUILD)/, $(notdir $(SRCS:.c=.o)))
OBJ_DIRS = $(sort $(dir $(OBJS)))

#add to FW_OBJS(export variable)
#FW_OBJS += $(wildcard $(BUILD)/*.o)

all: | $(OBJ_DIRS) $(OBJS)

$(OBJ_DIRS):
	$(MKDIR) -p $@

$(BUILD)/%.o : Src/%.c
	$(ECHO) "  CC      $(<F)"
	$(CC) $(CFLAGS) $(DEFS) $(INCS) -c -o $@ $<
