# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

# The package version (i.e. ${PV}) represents the video driver ABI version of
# the server, plus the version of the LDK that the driver comes from.  For
# example, the X driver for xserver 1.9 (which uses ABI version 8) from LDK
# version 1.2.3 would be tegra-drivers-8.1.2.3.

EAPI=4

inherit multilib versionator

DESCRIPTION="Tegra4 user-land drivers"
MY_ABI=$(get_major_version)
MY_PV=$(get_after_major_version)
SRC_URI="http://commondatastorage.googleapis.com/chromeos-localmirror/distfiles/${PN}-${MY_PV}.tbz2"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="arm"
IUSE=""

RDEPEND="~sys-apps/nvrm-${MY_PV}
	=x11-base/xorg-server-1.${MY_ABI}*"

S=${WORKDIR}

src_install() {
	exeinto /usr/$(get_libdir)/xorg/modules/drivers
	newexe usr/lib/xorg/modules/drivers/nvidia_drv.so nvidia_drv.so

	exeinto /usr/$(get_libdir)/xorg/modules/extensions
	newexe usr/lib/xorg/modules/extensions/libglx.so libglx.so
}
