BUILD ?= $(shell pwd)/../../../Build/BSPDriver/Components

##### CS43L22 Audio Codec driver #####
#SRCS += cs43l22/cs43l22.c

##### EXC7200 Touch-screen controller #####
#SRCS += exc7200/exc7200.c

##### FT6X06 IO Expander devices #####
#SRCS += ft6x06/ft6x06.c

##### LCD driver for ILI9325 LCD #####
#SRCS += ili9325/ili9325.c

##### LCD driver for ILI9341 LCD #####
#SRCS += ili9341/ili9341.c

##### L3GD20 ST MEMS motion sensor, 3-axis digital output gyroscope #####
#SRCS += l3gd20/l3gd20.c

##### LIS302DL MEMS Accelerometer #####
SRCS += lis302dl/lis302dl.c

##### LIS3DSH MEMS Accelerometer #####
SRCS += lis3dsh/lis3dsh.c

##### LCD driver for LS016B8UY LCD #####
#SRCS += ls016b8uy/ls016b8uy.c

##### lsm303dlhc MEMS accelerometer #####
#SRCS += lsm303dlhc/lsm303dlhc.c

##### MFXSTM32L152 IO Expander devices #####
#SRCS += mfxstm32l152/mfxstm32l152.c

##### LCD Driver for KoD KM-040TMP-02-0621 (WVGA) DSI LCD Display OTM8009A #####
#SRCS += otm8009a/otm8009a.c

##### OV2640 camera driver #####
#SRCS += ov2640/ov2640.c

##### S5K5CAG camera driver #####
#SRCS += s5k5cag/s5k5cag.c

##### driver for ST7735 LCD mounted on the Adafruit 1.8" TFT LCD shield (reference ID 802) #####
#SRCS += st7735/st7735.c

##### LCD driver for st7789h2 LCD #####
#SRCS += st7789h2/st7789h2.c

##### STMPE1600 IO Expander devices #####
#SRCS += stmpe1600/stmpe1600.c

##### STMPE811 IO Expander devices #####
#SRCS += stmpe811/stmpe811.c

##### TS3510 IO Expander devices #####
#SRCS += ts3510/ts3510.c

##### WM8994 Audio Codec driver #####
#SRCS += wm8994/wm8994.c

OBJS = $(addprefix $(BUILD)/, $(SRCS:.c=.o))
OBJ_DIRS = $(dir $(OBJS))

all: | $(OBJ_DIRS) $(OBJS)

$(OBJ_DIRS):
	$(MKDIR) -p $@

$(BUILD)/%.o: %.c
	$(ECHO) "  CC      $(<F)"
	$(CC) $(CFLAGS) $(DEFS) $(INCS) -c -o $@ $<

