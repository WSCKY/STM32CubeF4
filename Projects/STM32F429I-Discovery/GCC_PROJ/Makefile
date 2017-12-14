##################### Projrct Definition #####################
# Targets
ProjName = BSP_Demo
ProjPath = Projects/STM32F429I-Discovery/GCC_PROJ/BSP
# platform
BoardName = STM32F429I-Discovery
DEFS += -DSTM32F429xx
# Link file
LDFile = Proj/STM32F429ZITx_FLASH.ld
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
MKDIR   = $(Q)mkdir
ECHO    = $(Q)@echo
PRINTF  = $(Q)@printf
MAKE    = $(Q)make
CAT     = $(Q)cat

#project path
# TOP path
TopPath = $(shell pwd)/../../..
# BUILD path
BuildPath = $(TopPath)/Build
# Output path
OutPath = $(TopPath)/Output/$(ProjName)
# Main path
MainPath = $(TopPath)/$(ProjPath)
# HAL path
HALPath = $(TopPath)/Drivers/STM32F4xx_HAL_Driver
# BSP path
BSPPath = $(TopPath)/Drivers/BSP
# CMSIS path
CMSISPath = Drivers/CMSIS
# USB_Device path
#USBDPath = Middlewares/ST/STM32_USB_Device_Library
# Utilities path
UtilPath = $(TopPath)/Utilities

#public definition
DEFS += -DUSE_HAL_DRIVER
#includes
# -main include
INCS +=	-I$(MainPath)/Inc/
# -BSP include
INCS +=	-I$(BSPPath)/$(BoardName)/
# -HAL include
INCS +=	-I$(HALPath)/Inc/
# -CMSIS include
INCS +=	-I${TopPath}/$(CMSISPath)/Include/ \
        -I${TopPath}/$(CMSISPath)/Device/ST/STM32F4xx/Include/
# -Components include
#INCS += -I$(BSPPath)/Components/l3gd20/ \
#        -I$(BSPPath)/Components/ili9341/ \
#        -I$(BSPPath)/Components/stmpe811/
# -USB_Device include
#INCS += -I$(TopPath)/$(USBDPath)/Core/Inc \
#        -I$(TopPath)/$(USBDPath)/Class/HID/Inc
#INCS += -I${TopPath}/Middlewares/ST/STM32_Audio/Addons/PDM
# CMSIS LIB
#LIB_DIR += -L${TopPath}/$(CMSISPath)/Lib/GCC
#LIBS    += -llibarm_cortexM4lf_math
#LIB_DIR = -L${TopPath}/Middlewares/ST/STM32_Audio/Addons/PDM -l${TopPath}/Middlewares/ST/STM32_Audio/Addons/PDM/libPDMFilter_CM7F_GCC.a
#LIBS    += -llibPDMFilter_CM7F_GCC
# LIB
LIB_DIR += -L/home/kychu/GCC-ARM/gcc-arm-none-eabi-5_4-2016q3/arm-none-eabi/lib
LIBS += -lc

#OBJECTS
# -proj objects
FW_OBJS += $(wildcard $(BuildPath)/Projects/$(ProjName)/*.o)
# -BSP objects
FW_OBJS += $(wildcard $(BuildPath)/BSPDriver/$(BoardName)/*.o)
FW_OBJS += $(wildcard $(BuildPath)/Utilities/Log/*.o)
FW_OBJS += $(wildcard $(BuildPath)/BSPDriver/Components/l3gd20/*.o)
FW_OBJS += $(wildcard $(BuildPath)/BSPDriver/Components/ili9341/*.o)
FW_OBJS += $(wildcard $(BuildPath)/BSPDriver/Components/stmpe811/*.o)
#FW_OBJS += $(wildcard $(BuildPath)/BSPDriver/Components/lis3dsh/*.o)
#FW_OBJS += $(wildcard $(BuildPath)/BSPDriver/Components/lis302dl/*.o)
#FW_OBJS += $(wildcard $(BuildPath)/BSPDriver/Components/cs43l22/*.o)
# -HAL objects
FW_OBJS += $(wildcard $(BuildPath)/HALDriver/*.o)
# -USB_Device objects
#FW_OBJS += $(wildcard $(BuildPath)/USB_Device/Core/*.o)
#FW_OBJS += $(wildcard $(BuildPath)/USB_Device/Class/*.o)
# -lib objects
#FW_OBJS += libc.a

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
         -ffunction-sections -fdata-sections \
         -fsingle-precision-constant \
         -Wdouble-promotion \
         --specs=rdimon.specs \
         -Wl,--start-group -lgui -lgcc -lg -lc -lm -lrdimon -Wl,--end-group \
         -Wimplicit-function-declaration \
         -lnosys \
         -Wl,-gc-sections \
         -Wl,-g
#          -Wstrict-prototypes \
#         -Wredundant-decls -Wextra -Wmissing-prototypes
#         -Wundef -Wshadow
#         -fno-builtin \

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
export FW_OBJS
# -Path
export TopPath
export UtilPath

###################################################
all:$(ProjName)

$(BuildPath):
	$(MKDIR) -p $@
$(OutPath):
	$(MKDIR) -p $@

FIRMWARE_OBJS:
	$(MAKE) -C $(MainPath) $(MAKEFLAGS) BUILD=$(BuildPath)/Projects/$(ProjName)
	$(MAKE) -C $(HALPath)  $(MAKEFLAGS) BUILD=$(BuildPath)/HALDriver
#	$(MAKE) -C $(USBDPath) $(MAKEFLAGS) BUILD=$(BuildPath)/USB_Device             DEV_TYPE=HID
	$(MAKE) -C $(BSPPath)/$(BoardName) $(MAKEFLAGS) BUILD=$(BuildPath)/BSPDriver/$(BoardName)
	$(MAKE) -C $(UtilPath)/Log $(MAKEFLAGS) BUILD=$(BuildPath)/Utilities/Log
#	$(MAKE) -C $(BSPPath)/Components   $(MAKEFLAGS) BUILD=$(BuildPath)/BSPDriver/Components
	$(MAKE) -C $(BSPPath)/Components/l3gd20 $(MAKEFLAGS) BUILD=$(BuildPath)/BSPDriver/Components/l3gd20
	$(MAKE) -C $(BSPPath)/Components/ili9341 $(MAKEFLAGS) BUILD=$(BuildPath)/BSPDriver/Components/ili9341
	$(MAKE) -C $(BSPPath)/Components/stmpe811 $(MAKEFLAGS) BUILD=$(BuildPath)/BSPDriver/Components/stmpe811

$(ProjName): FIRMWARE_OBJS | $(BuildPath) $(OutPath)
	$(CPP) -P -E $(MainPath)/$(LDFile) > $(BuildPath)/stm32fxxx.lds
	$(CC) $(LDFLAGS) $(LIB_DIR) $(LIBS) $(FW_OBJS) -o $(OutPath)/$(ProjName).elf
	$(OBJCOPY) -Obinary -S $(OutPath)/$(ProjName).elf $(OutPath)/$(ProjName).bin
	$(SIZE) $(OutPath)/$(ProjName).elf

.PHONY: clean
clean:
	$(RM) -rf $(BuildPath) $(OutPath)

