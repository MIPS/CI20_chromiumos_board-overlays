# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit udev

DESCRIPTION="NVIDIA binary nvrm daemon and libraries for Tegra4"
SRC_URI="ftp://download.nvidia.com/chromeos/binary-ldk/t114/ER/${PV//./_}/nvidia-binaries_armhf_${PV//./_}.tbz2"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="arm"
IUSE=""

S=${WORKDIR}

src_unpack() {
	default
	unpack ./Linux_for_Tegra/nv_tegra/nvidia_drivers.tbz2
}

src_install() {
	insinto /lib/firmware
	doins lib/firmware/*.bin

	# Not all .so files in usr/lib get installed by this ebuild, so
	# let's list each one explicitly.
	dolib.so usr/lib/libcgdrv.so
	dolib.so usr/lib/libnvapputil.so
	dolib.so usr/lib/libnvcwm.so
	dolib.so usr/lib/libnvdc.so
	dolib.so usr/lib/libnvddk_2d.so
	dolib.so usr/lib/libnvddk_2d_v2.so
	dolib.so usr/lib/libnvddk_disp.so
	dolib.so usr/lib/libnvddk_mipihsi.so
	dolib.so usr/lib/libnvdispatch_helper.so
	dolib.so usr/lib/libnvavp.so
	dolib.so usr/lib/libnvmm_audio.so
	dolib.so usr/lib/libnvmm_camera.so
	dolib.so usr/lib/libnvmm_contentpipe.so
	dolib.so usr/lib/libnvmm_image.so
	dolib.so usr/lib/libnvmm_manager.so
	dolib.so usr/lib/libnvmm_parser.so
	dolib.so usr/lib/libnvmm_service.so
	dolib.so usr/lib/libnvmm.so
	dolib.so usr/lib/libnvmm_utils.so
	dolib.so usr/lib/libnvmm_video.so
	dolib.so usr/lib/libnvmm_writer.so
	dolib.so usr/lib/libnvmmlite.so
	dolib.so usr/lib/libnvmmlite_audio.so
	dolib.so usr/lib/libnvmmlite_image.so
	dolib.so usr/lib/libnvmmlite_utils.so
	dolib.so usr/lib/libnvmmlite_video.so
	dolib.so usr/lib/libnvos.so
	dolib.so usr/lib/libnvparser.so
	dolib.so usr/lib/libnvrm_graphics.so
	dolib.so usr/lib/libnvrm.so
	dolib.so usr/lib/libnvsm.so
	dolib.so usr/lib/libnvtestio.so
	dolib.so usr/lib/libnvtestresults.so
	dolib.so usr/lib/libnvtvmr.so
	dolib.so usr/lib/libnvwinsys.so
	dolib.so usr/lib/libnvwsi.so
	dolib.so usr/lib/libnvodm_dtvtuner.so
	dolib.so usr/lib/libnvodm_imager.so
	dolib.so usr/lib/libnvodm_misc.so
	dolib.so usr/lib/libnvodm_query.so
	dolib.so usr/lib/libnvodm_disp.so
	dolib.so usr/lib/libardrv_dynamic.so
	dolib.so usr/lib/libnvfusebypass.so
	dolib.so usr/lib/libnvglsi.so

	udev_dorules "${FILESDIR}"/51-nvrm.rules
}
