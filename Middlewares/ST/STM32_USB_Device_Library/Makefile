BUILD ?= $(shell pwd)/../../../Build/USB_Device

# source list
SRC_Core = $(wildcard Core/Src/*.c)
# folder list
Dirs = AUDIO  CDC  CustomHID  DFU  HID  MSC  Template
SRCS_Class += $(foreach dir, $(Dirs), $(wildcard Class/$(dir)/Src/*.c))
#get objects
OBJS = $(addprefix $(BUILD)/Core/, $(notdir $(SRC_Core:.c=.o)))
OBJS += $(addprefix $(BUILD)/, $(SRC_Class:.c=.o))
#get directory
OBJ_DIRS = $(sort $(dir $(OBJS)))
#add to FW_OBJS(export variable)
FW_OBJS += $(wildcard $(BUILD)/Core/*.o)
FW_OBJS += $(foreach dir, $(Dirs), $(wildcard $(BUILD)/Class/$(dir)/Src/*.o))

all: | $(OBJ_DIRS) $(OBJS)

$(OBJ_DIRS):
	echo $(OBJS)
	echo $(OBJ_DIRS)
	$(MKDIR) -p $@

$(BUILD)/%.o : %.c
	$(ECHO) "  CC      $(<F)"
	$(CC) $(CFLAGS) $(DEFS) $(INCS) -c -o $@ $<

$(BUILD)/Core/%.o : Core/Src/%.c
	$(ECHO) "  CC      $(<F)"
	$(CC) $(CFLAGS) $(DEFS) $(INCS) -c -o $@ $<

