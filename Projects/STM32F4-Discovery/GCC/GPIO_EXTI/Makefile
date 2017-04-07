# Set verbosity
ifeq ($(V), 1)
Q =
else
Q = @
endif

# Commands
CC      = $(Q)arm-none-eabi-gcc
AS      = $(Q)arm-none-eabi-as
LD      = $(Q)arm-none-eabi-ld
AR      = $(Q)arm-none-eabi-ar
RM      = $(Q)rm
CPP     = $(Q)arm-none-eabi-cpp
SIZE    = $(Q)arm-none-eabi-size
STRIP   = $(Q)arm-none-eabi-strip -s
OBJCOPY = $(Q)arm-none-eabi-objcopy
OBJDUMP = $(Q)arm-none-eabi-objdump
PYTHON  = $(Q)python
MKDFU   = micropython/tools/dfu.py
PYDFU   = $(Q)../usr/pydfu.py
MKDIR   = $(Q)mkdir
ECHO    = $(Q)@echo
PRINTF  = $(Q)@printf
MAKE    = $(Q)make
CAT     = $(Q)cat

SourcePath = /home/kychu/MyGit/STM32CubeF4
BuildPath = $(SourcePath)/Build

DEFS = -DUSE_HAL_DRIVER -DSTM32F407xx

INCS +=	-IInc/ \
        -I${SourcePath}/Drivers/BSP/STM32F4-Discovery \
        -I${SourcePath}/Drivers/BSP/Components/Common/ \
        -I${SourcePath}/Drivers/STM32F4xx_HAL_Driver/Inc/ \
        -I${SourcePath}/Drivers/CMSIS/Include/ \
        -I${SourcePath}/Drivers/CMSIS/Device/ST/STM32F4xx/Include/

OBJS += startup_stm32f407xx.o
OBJS += Src/main.o Src/stm32f4xx_it.o Src/system_stm32f4xx.o
OBJS += ${SourcePath}/Drivers/BSP/STM32F4-Discovery/stm32f4_discovery.o
OBJS += ${SourcePath}/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pwr_ex.o \
        ${SourcePath}/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_cortex.o \
        ${SourcePath}/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal.o \
        ${SourcePath}/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc.o \
        ${SourcePath}/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pwr.o \
        ${SourcePath}/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_gpio.o

DEBUG_FLAGS ?= -Os -ggdb3
FP_FLAGS ?= -mfpu=fpv4-sp-d16 -mfloat-abi=hard

CFLAGS += -std=gnu99 \
         -Wall \
         -Werror \
         -Warray-bounds \
         -mthumb \
         -nostartfiles \
         -mabi=aapcs-linux \
         -fdata-sections \
         -ffunction-sections \
         -fsingle-precision-constant \
         -Wdouble-promotion \
#         -fstack-protector-all \
         -g \
         -Wundef \
         -fno-builtin \
         -lnosys

CFLAGS += -mcpu=cortex-m4 -mtune=cortex-m4 $(DEBUG_FLAGS) $(FP_FLAGS)
LDFLAGS = -mcpu=cortex-m4 -mabi=aapcs-linux -mthumb $(FP_FLAGS) \
          -nostdlib -Wl,--gc-sections -Wl,-TSTM32F407VGTx_FLASH.ld

all:GPIO_EXTI.bin

$(BuildPath):
	$(MKDIR) -p $@

GPIO_EXTI.bin:GPIO_EXTI.elf | $(BuildPath)
	$(OBJCOPY) -O binary -S $< $@

GPIO_EXTI.elf:$(OBJS)
	$(CC) $(LDFLAGS) $^ -o $@
	$(SIZE) $@
%.o:%.S
	$(CC) $(CFLAGS) -c $< -o $@
%.o:%.c
	$(ECHO) "  CC      $(<F)"
	$(CC) $(CFLAGS) $(DEFS) $(INCS) -c $< -o $@

.PHONY: clean
clean:
	$(RM) -rf $(OBJS) GPIO_EXTI.*
