BUILD ?= $(shell pwd)/../../../Build/BSPDriver/STM32F429I-Discovery

# source list
#SRCS = $(wildcard *.c)
SRCS += stm32f429i_discovery.c
SRCS += stm32f429i_discovery_eeprom.c
SRCS += stm32f429i_discovery_gyroscope.c
SRCS += stm32f429i_discovery_io.c
SRCS += stm32f429i_discovery_lcd.c
SRCS += stm32f429i_discovery_sdram.c
SRCS += stm32f429i_discovery_ts.c

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
