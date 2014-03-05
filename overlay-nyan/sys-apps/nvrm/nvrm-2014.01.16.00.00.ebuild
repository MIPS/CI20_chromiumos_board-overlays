# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit udev

DESCRIPTION="NVIDIA binary nvrm daemon and libraries for Tegra4"
SRC_URI="http://commondatastorage.googleapis.com/chromeos-localmirror/distfiles/${P}.tbz2"

LICENSE="NVIDIA-r2"
SLOT="0"
KEYWORDS="arm"
IUSE=""

S=${WORKDIR}

src_install() {
	local sover='19.003'

	insinto /lib/firmware
	doins lib/firmware/nvavp_os_0ff00000.bin
	doins lib/firmware/nvavp_os_8ff00000.bin
	doins lib/firmware/nvavp_os_eff00000.bin
	doins lib/firmware/nvavp_vid_ucode_alt.bin

	insinto /lib/firmware/tegra12x
	doins lib/firmware/tegra12x/gpmu_ucode.bin
	doins lib/firmware/tegra12x/NETB_img.bin
	doins lib/firmware/tegra12x/gpccs.bin
	doins lib/firmware/tegra12x/fecs.bin

	dolib.so usr/lib/libardrv_dynamic.so
	dolib.so usr/lib/libnvapputil.so
	dolib.so usr/lib/libnvglsi.so
	dolib.so usr/lib/libnvavp.so
	dolib.so usr/lib/libnvcwm.so
	dolib.so usr/lib/libnvdc.so
	dolib.so usr/lib/libnvddk_2d_v2.so
	dolib.so usr/lib/libnvddk_vic.so
	dolib.so usr/lib/libnvfusebypass.so
	dolib.so usr/lib/libnvidia-eglcore.so.${sover}
	dosym libnvidia-eglcore.so.${sover} /usr/$(get_libdir)/libnvidia-eglcore.so
	dolib.so usr/lib/libnvidia-glcore.so.${sover}
	dosym libnvidia-glcore.so.${sover} /usr/$(get_libdir)/libnvidia-glcore.so
	dolib.so usr/lib/libnvidia-glsi.so.${sover}
	dosym libnvidia-glsi.so.${sover} /usr/$(get_libdir)/libnvidia-glsi.so
	dolib.so usr/lib/libnvidia-rmapi-tegra.so.${sover}
	dosym libnvidia-rmapi-tegra.so.${sover} /usr/$(get_libdir)/libnvidia-rmapi-tegra.so
	dolib.so usr/lib/libnvidia-tls.so.${sover}
	dosym libnvidia-tls.so.${sover} /usr/$(get_libdir)/libnvidia-tls.so
	dolib.so usr/lib/libnvmm_audio.so
	dolib.so usr/lib/libnvmm_camera.so
	dolib.so usr/lib/libnvmm_contentpipe.so
	dolib.so usr/lib/libnvmmlite_audio.so
	dolib.so usr/lib/libnvmmlite_image.so
	dolib.so usr/lib/libnvmmlite.so
	dolib.so usr/lib/libnvmmlite_utils.so
	dolib.so usr/lib/libnvmmlite_video.so
	dolib.so usr/lib/libnvmm_parser.so
	dolib.so usr/lib/libnvmm.so
	dolib.so usr/lib/libnvmm_utils.so
	dolib.so usr/lib/libnvmm_writer.so
	dolib.so usr/lib/libnvodm_imager.so
	dolib.so usr/lib/libnvodm_query.so
	dolib.so usr/lib/libnvos.so
	dolib.so usr/lib/libnvparser.so
	dolib.so usr/lib/libnvrm_graphics.so
	dolib.so usr/lib/libnvrm.so
	dolib.so usr/lib/libnvsm.so
	dolib.so usr/lib/libnvtestio.so
	dolib.so usr/lib/libnvtestresults.so
	dolib.so usr/lib/libnvtnr.so
	dolib.so usr/lib/libnvtvmr.so
	dolib.so usr/lib/libnvwinsys.so
	dolib.so usr/lib/libnvwsi.so
	dolib.so usr/lib/libtegrav4l2.so

	udev_dorules "${FILESDIR}"/51-nvrm.rules
}
