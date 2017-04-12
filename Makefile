##################### Projrct Definition #####################
# Targets
#ProjName = GPIO_EXTI
#ProjPath = Projects/STM32F4-Discovery/GCC/GPIO_EXTI
ProjName = Demonstrations
ProjPath = Projects/STM32F4-Discovery/Demonstrations
# platform
BoardName = STM32F4-Discovery
DEFS += -DSTM32F407xx -DUSE_STM32F4_DISCO
# Link file
LDFile = STM32F407VGTx_FLASH.ld
##################### Projrct Definition #####################

# Set verbosity
ifeq ($(V), 1)
Q =
else
Q = @
# Do not print "Entering directory ...".
MAKEFLAGS += --no-print-directory
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

#project path
# TOP path
TopPath = $(shell pwd)
# BUILD path
BuildPath = $(TopPath)/Build
# Output path
OutPath = $(TopPath)/Output/$(ProjName)
# Main path
MainPath = $(TopPath)/$(ProjPath)
# HAL path
HALPath = Drivers/STM32F4xx_HAL_Driver
# BSP path
BSPPath = Drivers/BSP
# CMSIS path
CMSISPath = Drivers/CMSIS
# USB_Device path
USBDPath = Middlewares/ST/STM32_USB_Device_Library

#public definition
DEFS += -DUSE_HAL_DRIVER
#includes
# -main include
INCS +=	-I$(MainPath)/Inc/
# -BSP include
INCS +=	-I${TopPath}/$(BSPPath)/$(BoardName)
# -HAL include
INCS +=	-I${TopPath}/$(HALPath)/Inc/
# -CMSIS include
INCS +=	-I${TopPath}/$(CMSISPath)/Include/ \
        -I${TopPath}/$(CMSISPath)/Device/ST/STM32F4xx/Include/
# -USB_Device include
INCS += -I$(TopPath)/$(USBDPath)/Core/Inc \
        -I$(TopPath)/$(USBDPath)/Class/HID/Inc

# CMSIS LIB
LIB_DIR += -L${TopPath}/$(CMSISPath)/Lib/GCC
LIBS    += -l${TopPath}/$(CMSISPath)/Lib/GCC/libarm_cortexM4lf_math.a

#OBJECTS
# -proj objects
FW_OBJS += $(wildcard $(BuildPath)/Projects/$(ProjName)/*.o)
# -BSP objects
FW_OBJS += $(wildcard $(BuildPath)/BSPDriver/$(BoardName)/*.o)
FW_OBJS += $(wildcard $(BuildPath)/BSPDriver/Components/lis3dsh/*.o)
FW_OBJS += $(wildcard $(BuildPath)/BSPDriver/Components/lis302dl/*.o)
# -HAL objects
FW_OBJS += $(wildcard $(BuildPath)/HALDriver/*.o)
# -USB_Device objects
FW_OBJS += $(wildcard $(BuildPath)/USB_Device/Core/*.o)
FW_OBJS += $(wildcard $(BuildPath)/USB_Device/Class/*.o)

#Debugging/Optimization
DEBUG_FLAGS ?= -Os -ggdb3
#FPU settings
FP_FLAGS ?= -mfpu=fpv4-sp-d16 -mfloat-abi=hard
#Compiler Flags
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
         --specs=rdimon.specs \
         -Wl,--start-group -lgcc -lc -lm -lrdimon -Wl,--end-group
#         -g \
#         -Wundef \
#         -fno-builtin \
#         -lnosys

CFLAGS += -mcpu=cortex-m4 -mtune=cortex-m4 $(DEBUG_FLAGS) $(FP_FLAGS)
LDFLAGS = -mcpu=cortex-m4 -mabi=aapcs-linux -mthumb $(FP_FLAGS) \
          -nostdlib -Wl,--gc-sections -Wl,-T$(BuildPath)/stm32fxxx.lds

#Export Variables
# -Operate
export Q
export CC
export AS
export LD
export AR
export SIZE
export OBJCOPY
export OBJDUMP
export MKDIR
export ECHO
# -Variables
export CFLAGS
export LDFLAGS
export DEFS
export INCS
#export FW_OBJS

###################################################
all:$(ProjName)

$(BuildPath):
	$(MKDIR) -p $@
$(OutPath):
	$(MKDIR) -p $@

FIRMWARE_OBJS:
	$(MAKE) -C $(ProjPath) $(MAKEFLAGS) BUILD=$(BuildPath)/Projects/$(ProjName)
	$(MAKE) -C $(HALPath)  $(MAKEFLAGS) BUILD=$(BuildPath)/HALDriver
	$(MAKE) -C $(USBDPath) $(MAKEFLAGS) BUILD=$(BuildPath)/USB_Device             DEV_TYPE=HID
	$(MAKE) -C $(BSPPath)/$(BoardName) $(MAKEFLAGS) BUILD=$(BuildPath)/BSPDriver/$(BoardName)
	$(MAKE) -C $(BSPPath)/Components   $(MAKEFLAGS) BUILD=$(BuildPath)/BSPDriver/Components

$(ProjName): FIRMWARE_OBJS | $(BuildPath) $(OutPath)
	$(CPP) -P -E $(ProjPath)/$(LDFile) > $(BuildPath)/stm32fxxx.lds
	$(CC) $(LDFLAGS) $(FW_OBJS) -o $(OutPath)/$(ProjName).elf
	$(OBJCOPY) -Obinary -S $(OutPath)/$(ProjName).elf $(OutPath)/$(ProjName).bin
	$(SIZE) $(OutPath)/$(ProjName).elf

.PHONY: clean
clean:
	$(RM) -rf $(BuildPath) $(OutPath)

