# Copyright (c) 2013, NVIDIA CORPORATION.  All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#  * Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#  * Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#  * Neither the name of NVIDIA CORPORATION nor the names of its
#    contributors may be used to endorse or promote products derived
#    from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
# OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

EAPI=4

inherit udev

DESCRIPTION="NVIDIA binary nvrm daemon and libraries for Tegra4"
SRC_URI="ftp://download.nvidia.com/chromeos/binary-ldk/t114/ER/2013_01_25_00_00/nvidia-binaries_armhf_2013_01_25_00_00.tbz2"

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
