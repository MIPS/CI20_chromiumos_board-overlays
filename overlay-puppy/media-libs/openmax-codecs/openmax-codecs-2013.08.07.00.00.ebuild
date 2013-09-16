# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="OpenMAX binary libraries"
SRC_URI="ftp://download.nvidia.com/chromeos/binary-ldk/t114/ER/${PV//./_}/nvidia-codecs_armhf_${PV//./_}.tbz2"

LICENSE="NVIDIA-codecs"
SLOT="0"
KEYWORDS="arm"
IUSE=""

RDEPEND="=sys-apps/nvrm-${PV}
	virtual/opengles
	"

S=${WORKDIR}

src_unpack() {
	default
	unpack ./restricted_codecs.tbz2
}

src_install() {
	insinto /lib/firmware/tegra11x
	doins lib/firmware/tegra11x/nvhost_msenc02.fw
}
