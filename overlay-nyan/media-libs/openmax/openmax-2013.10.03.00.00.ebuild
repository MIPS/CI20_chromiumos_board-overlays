# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit multilib

DESCRIPTION="OpenMAX binary libraries"
SRC_URI="ftp://download.nvidia.com/chromeos/binary-ldk/t124/ER/${PV//./_}/nvidia-binaries_armhf_${PV//./_}.tbz2"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="arm"
IUSE=""

RDEPEND="=sys-apps/nvrm-${PV}
	virtual/opengles
	"

S=${WORKDIR}

src_unpack() {
	default
	unpack ./Linux_for_Tegra/nv_tegra/nvidia_drivers.tbz2
}

src_install() {
	dolib.so usr/lib/arm-linux-gnueabihf/tegra/libnvomxilclient.so
	dolib.so usr/lib/arm-linux-gnueabihf/tegra/libnvomx.so
	dosym libnvomx.so /usr/$(get_libdir)/libOmxCore.so
}
