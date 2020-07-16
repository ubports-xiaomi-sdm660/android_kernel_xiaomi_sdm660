#!/bin/bash
#
# Copyright © 2018, "Vipul Jha" aka "LordArcadius" <vipuljha08@gmail.com>
# Copyright © 2018, "penglezos" <panagiotisegl@gmail.com>
# Copyright © 2018, "reza adi pangestu" <rezaadipangestu385@gmail.com>
# Copyright © 2018, "beamguide" <beamguide@gmail.com>
# Customized by "DerFlacco" <paul89rulez@gmail.com>
# Customized by "robante15" <robante12@gmail.com>

BUILD_START=$(date +"%s")
DATE=$(date +%Y%m%d-%H%M)

KERNEL_DIR=$PWD
REPACK_DIR=$KERNEL_DIR/zip
OUT=$KERNEL_DIR/output

#EXPORT VARIABLES
VERSION="SDM660_Halium"
ZIP_NAME="Kernel-${VERSION}-${DATE}.zip"

#BUILD VARIABLES
read -p "Enter your defconfig [jasmine-perf_defconfig]: " DEFCONFIG
DEFCONFIG=${DEFCONFIG:-jasmine-perf_defconfig}
echo $DEFCONFIG

read -p "Enter the number of jobs [8]: " JOBS
JOBS=${JOBS:-8}
echo $JOBS

OUTPUT=output

export ARCH=arm64
export SUBARCH=arm64
export CROSS_COMPILE="/mnt/LinuxGames/Mi_A2/Esencial/toolchain/bin/aarch64-linux-gnu-"
export CROSS_COMPILE_ARM32="/mnt/LinuxGames/Mi_A2/Esencial/toolchain32/bin/arm-linux-gnueabihf-"

make_zip(){
        cd $REPACK_DIR
			cp $KERNEL_DIR/$OUTPUT/arch/arm64/boot/Image.gz-dtb $REPACK_DIR/
			zip -r9 "${ZIP_NAME}" *
			cp *.zip $OUT
			rm *.zip
			rm -rf kernel
			rm -rf dtbs
		cd $KERNEL_DIR
}

make clean && make mrproper
make O=$OUTPUT $DEFCONFIG
# make -j$(nproc --all) O=$OUTPUT 2>&1 | tee kernel.log
make -j$JOBS O=$OUTPUT 2>&1 | tee kernel.log

make_zip

BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
rm -rf zip/kernel
rm -rf zip/Image.gz-dtb
rm -rf zip/dtbs
echo -e ""
echo -e ""
echo -e "Done!"
echo -e ""
echo -e ""
echo -e "Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
echo -e "Configuration used:"
echo -e "defconfig: $DEFCONFIG"
