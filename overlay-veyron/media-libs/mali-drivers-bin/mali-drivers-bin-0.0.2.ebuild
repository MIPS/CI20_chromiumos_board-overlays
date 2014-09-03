# Copyright 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit multilib

DESCRIPTION="Mali prebuilt libs for rk32, including libmali.so and pkgconfig"
SRC_URI="https://github.com/rkchrome/mali-drivers-bin/archive/${PV}.tar.gz -> rkchrome-${P}.tar.gz"
RESTRICT=mirror

LICENSE="Google-TOS"
SLOT="0"
KEYWORDS="-* arm"

DEPEND="
	x11-drivers/opengles-headers
	"

RDEPEND="
	!media-libs/mali-drivers
	x11-base/xorg-server
	x11-drivers/xf86-video-armsoc
	!x11-drivers/opengles
	x11-libs/libdrm
	"

src_install() {
	emake DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)" install
}
