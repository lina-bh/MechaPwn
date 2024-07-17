cd irx/source/mechaproxy
make
cd -
cp irx/source/mechaproxy/irx/mechaproxy.irx irx/compiled/mechaproxy.irx

cd irx/source/masswatcher
make
cd -
cp irx/source/masswatcher/irx/masswatcher.irx irx/compiled/masswatcher.irx

make -j4
mips64r5900el-ps2-elf-strip -s MechaPwn.elf; exit $?
