BUILD ?= $(shell pwd)
# source list
SRC_S = Proj/startup_stm32f429xx.s
SRC_C = $(wildcard Src/*.c)
SRC_C += Proj/syscalls.c

OBJS  = $(addprefix $(BUILD)/, $(notdir $(SRC_S:.s=.o)))
OBJS += $(addprefix $(BUILD)/, $(notdir $(SRC_C:.c=.o)))
OBJ_DIRS = $(sort $(dir $(OBJS)))

INCS += -I$(UtilPath)/Log/

all: | $(OBJ_DIRS) $(OBJS)

$(OBJ_DIRS):
	$(MKDIR) -p $@

$(BUILD)/%.o : Src/%.c
	$(ECHO) "  CC      $(<F)"
	$(CC) $(CFLAGS) $(DEFS) $(INCS) -c -o $@ $<

$(BUILD)/%.o : Proj/%.c
	$(ECHO) "  CC      $(<F)"
	$(CC) $(CFLAGS) $(DEFS) $(INCS) -c -o $@ $<

$(BUILD)/%.o : Proj/%.s
	$(ECHO) "  AS      $(<F)"
	$(AS) $(AFLAGS) $< -o $@
#	$(CC) -x assembler-with-cpp \
#              -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16 \
#              -Wa,-adhlns="$@.lst" -c -fmessage-length=0 \
#              -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" $< -o $@

