BUILD ?= $(shell pwd)
# source list
SRC_S = startup_stm32f407xx.s
SRC_C = $(wildcard Src/*.c)

OBJS  = $(addprefix $(BUILD)/, $(SRC_S:.s=.o))
OBJS += $(addprefix $(BUILD)/, $(notdir $(SRC_C:.c=.o)))
OBJ_DIRS = $(sort $(dir $(OBJS)))

FW_OBJS += $(wildcard $(BUILD)/*.o)

all: | $(OBJ_DIRS) $(OBJS)

$(OBJ_DIRS):
	$(MKDIR) -p $@

$(BUILD)/%.o : Src/%.c
	$(ECHO) "  CC      $(<F)"
	$(CC) $(CFLAGS) $(DEFS) $(INCS) -c -o $@ $<

$(BUILD)/%.o : %.s
	$(ECHO) "  AS      $(<F)"
	$(AS) $(AFLAGS) $< -o $@

