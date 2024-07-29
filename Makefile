EE_BIN = MechaPwn.elf
IRX_DIR = irx/compiled
EE_PACKED_BIN = MechaPwn_pck.elf

# C File
EE_OBJS = main.o mecha.o exploit.o pad.o ui.o mass.o
EE_OBJS += iomanX.o fileXio.o freesio2.o freepad.o mcman.o mcsrv.o USBD.o USBHDFSD.o IndieFlower.o
EE_OBJS += MECHAPROXY_irx.o MASSWATCHER_irx.o pwr50k.o pwr70k.o pwr90k.o pwrpsx1.o pwrpsx2.o pwrtvcombo.o frame_001.o frame_002.o frame_003.o frame_004.o frame_005.o frame_006.o frame_007.o frame_008.o frame_009.o frame_010.o frame_011.o frame_012.o frame_013.o frame_014.o frame_015.o frame_016.o frame_017.o frame_018.o frame_019.o frame_020.o frame_021.o frame_022.o frame_023.o frame_024.o frame_025.o frame_026.o frame_027.o frame_028.o frame_029.o frame_030.o frame_031.o frame_032.o frame_033.o frame_034.o frame_035.o frame_036.o frame_037.o frame_038.o frame_039.o frame_040.o frame_041.o frame_042.o frame_043.o frame_044.o frame_045.o frame_046.o frame_047.o frame_048.o frame_049.o frame_050.o frame_051.o frame_052.o frame_053.o frame_054.o frame_055.o frame_056.o frame_057.o frame_058.o frame_059.o frame_060.o frame_061.o frame_062.o

EE_INCS = -I$(PS2SDK)/ports/include -I$(PS2SDK)/sbv/include -I$(PS2SDK)/common/include -I./irx/source/mechaproxy/include/ -I./irx/source/masswatcher/include/ -I$(PS2SDK)/ports/include/freetype2 -I$(GSKIT)/include
EE_LDFLAGS = -L$(PS2SDK)/sbv/lib -L$(PS2SDK)/ports/lib -L$(GSKIT)/lib
EE_LIBS = -lpatches -lpadx -lmc -lfreetype -lpng -lz -lgskit -lgskit_toolkit -ldmakit -lfileXio
EE_CFLAGS = -std=c99

BIN2S = $(PS2SDK)/bin/bin2c

all: $(EE_BIN)
	ps2-packer $(EE_BIN) $(EE_PACKED_BIN)

clean:
	make clean -C irx/source/mechaproxy
	make clean -C irx/source/masswatcher
	rm -f *.elf *.o *.s resources/*.bin resources/*.pyc *.pyc

#IRX Modules
iomanX.c:
	$(BIN2S) $(PS2SDK)/iop/irx/iomanX.irx iomanX.c iomanX
fileXio.c:
	$(BIN2S) $(PS2SDK)/iop/irx/fileXio.irx fileXio.c fileXio
freesio2.c:
	$(BIN2S) $(PS2SDK)/iop/irx/freesio2.irx freesio2.c freesio2
freepad.c:
	$(BIN2S) $(PS2SDK)/iop/irx/freepad.irx freepad.c freepad
mcman.c:
	$(BIN2S) $(PS2SDK)/iop/irx/mcman.irx mcman.c mcman
mcsrv.c:
	$(BIN2S) $(PS2SDK)/iop/irx/mcserv.irx mcsrv.c mcserv
USBD.c: $(PS2SDK)/iop/irx/usbd.irx
	$(BIN2S) $(PS2SDK)/iop/irx/usbd.irx USBD.c USBD
USBHDFSD.c: $(PS2SDK)/iop/irx/usbhdfsd.irx
	$(BIN2S) $(PS2SDK)/iop/irx/usbhdfsd.irx USBHDFSD.c USBHDFSD
MECHAPROXY_irx.c:
	$(MAKE) -C irx/source/mechaproxy
	$(BIN2S) irx/source/mechaproxy/irx/mechaproxy.irx MECHAPROXY_irx.c MECHAPROXY_irx
MASSWATCHER_irx.c:
	$(MAKE) -C irx/source/masswatcher
	$(BIN2S) irx/source/masswatcher/irx/masswatcher.irx MASSWATCHER_irx.c MASSWATCHER_irx
IndieFlower.c: resources/IndieFlower-Regular.ttf
	$(BIN2S) resources/IndieFlower-Regular.ttf IndieFlower.c IndieFlower

%.c: resources/%
	$(BIN2S) $^ $@ $(^F)

resources/%: resources/%.png
	python3 resources/conv.py $^ $@

include $(PS2SDK)/samples/Makefile.pref
include $(PS2SDK)/samples/Makefile.eeglobal
