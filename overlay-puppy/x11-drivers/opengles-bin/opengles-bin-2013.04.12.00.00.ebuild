# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit multilib

DESCRIPTION="NVIDIA binary OpenGL|ES libraries for Tegra4"
SRC_URI="ftp://download.nvidia.com/chromeos/binary-ldk/t114/ER/${PV//./_}/nvidia-binaries_armhf_${PV//./_}.tbz2"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="arm"
IUSE=""

DEPEND="
	x11-drivers/opengles-headers
	"

RDEPEND="=sys-apps/nvrm-${PV}
	!x11-drivers/opengles"

S=${WORKDIR}

src_unpack() {
	default
	unpack ./Linux_for_Tegra/nv_tegra/nvidia_drivers.tbz2
}

src_install() {
	dolib.so usr/lib/libEGL.so.1
	dosym libEGL.so.1 /usr/$(get_libdir)/libEGL.so

	dolib.so usr/lib/libGLESv2.so.2
	dosym libGLESv2.so.2 /usr/$(get_libdir)/libGLESv2.so
}
