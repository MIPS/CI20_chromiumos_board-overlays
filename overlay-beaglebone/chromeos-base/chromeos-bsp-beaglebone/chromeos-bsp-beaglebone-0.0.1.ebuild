# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

DESCRIPTION="Beaglebone bsp (meta package to pull in driver/tool dependencies)"

LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE=""

# TODO(jrbarnette):  The sys-boot/u-boot package is meant to have a
# short lifetime; we'd rather depend on virtual/u-boot instead.
# http://crbug.com/302022
DEPEND=""
RDEPEND="
	chromeos-base/serial-tty
	dev-util/hdctools
	sys-boot/u-boot
"
