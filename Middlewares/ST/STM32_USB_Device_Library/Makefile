BUILD ?= $(shell pwd)/../../../Build/USB_Device
DEV_TYPE ?= HID

# source list
SRC_Core = $(wildcard Core/Src/*.c)
# folder list
#Dirs = AUDIO  CDC  CustomHID  DFU  HID  MSC
#SRC_Class += $(foreach dir, $(Dirs), $(wildcard Class/$(dir)/Src/*.c))
SRC_Class += $(wildcard Class/$(DEV_TYPE)/Src/*.c)
#get objects
OBJS = $(addprefix $(BUILD)/Core/, $(notdir $(SRC_Core:.c=.o)))
OBJS += $(addprefix $(BUILD)/Class/, $(notdir $(SRC_Class:.c=.o)))
#get directory
OBJ_DIRS = $(sort $(dir $(OBJS)))

#add to FW_OBJS(export variable)
#FW_OBJS += $(wildcard $(BUILD)/Core/*.o)
#FW_OBJS += $(foreach dir, $(Dirs), $(wildcard $(BUILD)/Class/$(dir)/Src/*.o))

all: | $(OBJ_DIRS) $(OBJS)

$(OBJ_DIRS):
	$(MKDIR) -p $@

$(BUILD)/Class/%.o : Class/$(DEV_TYPE)/Src/%.c
	$(ECHO) "  CC      $(<F)"
	$(CC) $(CFLAGS) $(DEFS) $(INCS) -c -o $@ $<

$(BUILD)/Core/%.o : Core/Src/%.c
	$(ECHO) "  CC      $(<F)"
	$(CC) $(CFLAGS) $(DEFS) $(INCS) -c -o $@ $<

