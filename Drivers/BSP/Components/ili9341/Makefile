BUILD ?= $(shell pwd)/../../../../Build/Drivers/Components/ili9341

# source list
SRCS = $(wildcard *.c)

OBJS = $(addprefix $(BUILD)/, $(SRCS:.c=.o))
OBJ_DIRS = $(sort $(dir $(OBJS)))

#add to FW_OBJS(export variable)
#FW_OBJS += $(wildcard $(BUILD)/*.o)

all: | $(OBJ_DIRS) $(OBJS)

$(OBJ_DIRS):
	$(MKDIR) -p $@

$(BUILD)/%.o : %.c
	$(ECHO) "  CC      $(<F)"
	$(CC) $(CFLAGS) $(DEFS) $(INCS) -c -o $@ $<
