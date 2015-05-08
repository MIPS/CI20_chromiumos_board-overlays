#!/bin/sh -e
#
# Copyright (c) 2013-2015 Imagination Technologies
# Authors:
#  Paul Burton <paul.burton@imgtec.com>
#  James Cowgill <james.cowgill@imgtec.com>
#
# Creates an sdcard image which will flash u-boot, an environment and a kernel (no rootfs)
# ./make-nand-image.sh <path to uboot files> <path to kernel> <path to initial environment> <output image>

tmpDir=`mktemp -d`

cleanup()
{
  echo "Cleaning up..."
  [ -z "${sdMount}" ] || sudo umount ${sdMount}
  rm -rf ${tmpDir}
  trap - EXIT INT TERM
}
trap cleanup EXIT INT TERM

die()
{
  echo "$@" >&2
  exit 1
}

# Verify all inputs exist
uboot_path="$1"
([ -d "$uboot_path" ] && \
  [ -e "$uboot_path/u-boot-mmc.img" ] && \
  [ -e "$uboot_path/u-boot-nand.img" ] && \
  [ -e "$uboot_path/u-boot-spl-mmc.bin" ] && \
  [ -e "$uboot_path/u-boot-spl-nand.bin" ] && \
  [ -x "$uboot_path/mkenvimage" ]) || die "u-boot files do not exist"

vmlinux="$2"
[ -e "${vmlinux}" ] || die "Kernel (vmlinux) '${vmlinux}' not found"

uboot_nand_env="$3"
[ -e "${uboot_nand_env}" ] || die "uboot environment file not found"

image="$4"
[ -n "${image}" ] || die "provide an output image name"

# check for tools
export PATH="$PATH:/sbin:/usr/sbin"
which bc >/dev/null || die "No bc in \$PATH"
which sfdisk >/dev/null || die "No sfdisk in \$PATH"
which mkfs.ext2 >/dev/null || die "No mkfs.ext2 in \$PATH"
which mkfs.ubifs >/dev/null || die "No mkfs.ubifs in \$PATH"

# Create SD card image
#  32MB boot partition + ext2 overhead + uboot images
rm -f ${image}
fallocate -l 40M ${image}

# Partition image (4096 sectors = 2MiB)
# sfdisk before 2.26 is a bit broken so we have to use -uM there
if sfdisk -uM 2>&1 | grep -q 'unsupported unit'; then
  echo '4096,,L' | sfdisk ${image}
else
  echo '2,,L' | sfdisk -uM -L ${image}
fi

# create ext2 partition
mkfs.ext2 -F -E offset=$((2*1024*1024)),nodiscard ${image} 38M

# mount ext2 partition
sdMount=${tmpDir}/sd_mount
mkdir ${sdMount}
sudo mount -o loop,offset=$((2*1024*1024)) ${image} ${sdMount}

# Install mmc uboot directly onto image
dd if="$uboot_path/u-boot-spl-mmc.bin" of=${image} obs=512 seek=1 conv=notrunc
dd if="$uboot_path/u-boot-mmc.img" of=${image} obs=1K seek=14 conv=notrunc

# Generate NAND u-boot environment
nand_env_bin=${tmpDir}/u-boot-env-nand.bin
envSize=$((32 * 1024))
echo "NAND U-boot environment:"
cat ${uboot_nand_env}
"${uboot_path}/mkenvimage" -s ${envSize} -o ${nand_env_bin} ${uboot_nand_env}

# Copy nand uboot onto filesystem
sudo cp -v "$uboot_path/u-boot-spl-nand.bin" ${sdMount}/
sudo cp -v "$uboot_path/u-boot-nand.img" ${sdMount}/
sudo cp -v "$nand_env_bin" ${sdMount}/

# Create ubi boot partition
bootPartDir=${tmpDir}/boot_partition
bootImage=${tmpDir}/boot.ubifs
mkdir ${bootPartDir}
cp -v "${vmlinux}" ${bootPartDir}/vmlinux.img
mkfs.ubifs -q -r ${bootPartDir} -m 8192 -e 2080768 -c 128 -o ${bootImage}
sudo cp -v ${bootImage} ${sdMount}/

# generate (SD/MMC) u-boot environment
envText=${tmpDir}/u-boot-env.txt
envBin=${tmpDir}/u-boot-env.bin
bootCmd="mw.l 0xb0010548 0x8000; \
mtdparts default; \
nand erase.chip; \
ext4load mmc 0:1 0x80000000 u-boot-spl-nand.bin; \
writespl 0x80000000 8; \
ext4load mmc 0:1 0x80000000 u-boot-env-nand.bin; \
nand write 0x80000000 uboot-env 0x80000; \
ext4load mmc 0:1 0x80000000 u-boot-nand.img; \
nand write 0x80000000 uboot 0x80000; \
ubi part system; \
ubi create boot 0x4000000; \
ext4load mmc 0:1 0x80000000 boot.ubifs; \
ubi write 0x80000000 boot \${filesize}; \
mw.l 0xb0010544 0x8000; echo All done :)"
echo "bootcmd=${bootCmd}" >${envText}

echo "MMC U-boot environment:"
cat ${envText}
"${uboot_path}/mkenvimage" -s ${envSize} -o ${envBin} ${envText}
dd if=${envBin} of=${image} obs=1 seek=$((526 * 1024)) conv=notrunc
