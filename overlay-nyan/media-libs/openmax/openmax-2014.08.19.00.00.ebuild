# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit multilib

DESCRIPTION="OpenMAX binary libraries"
SRC_URI="http://commondatastorage.googleapis.com/chromeos-localmirror/distfiles/${P}.tbz2"

LICENSE="NVIDIA-r2"
SLOT="0"
KEYWORDS="arm"
IUSE=""

RDEPEND="~sys-apps/nvrm-${PV}
	virtual/opengles
	"

S=${WORKDIR}

src_install() {
	dolib.so usr/lib/libnvomxilclient.so
	dolib.so usr/lib/libnvomx.so
	dosym libnvomx.so /usr/$(get_libdir)/libOmxCore.so
}
