# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit multilib

DESCRIPTION="NVIDIA binary OpenGL|ES libraries for Tegra4"
SRC_URI="http://commondatastorage.googleapis.com/chromeos-localmirror/distfiles/${P}.tbz2"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="arm"
IUSE=""

RDEPEND="~sys-apps/nvrm-${PV}
	x11-drivers/opengles-headers
	!x11-drivers/opengles"

S=${WORKDIR}

src_install() {
	dolib.so usr/lib/libEGL.so.1
	dosym libEGL.so.1 /usr/$(get_libdir)/libEGL.so

	dolib.so usr/lib/libGLESv1_CM.so.1
	dosym libGLESv1_CM.so.1 /usr/$(get_libdir)/libGLESv1_CM.so

	dolib.so usr/lib/libGLESv2.so.2
	dosym libGLESv2.so.2 /usr/$(get_libdir)/libGLESv2.so

	# manually installs pkg config files
	insinto /usr/$(get_libdir)/pkgconfig
	doins "${FILESDIR}"/{egl,glesv2}.pc
}
