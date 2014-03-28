# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Beaglebone bsp (meta package to pull in driver/tool dependencies)"

LICENSE="BSD"
SLOT="0"
KEYWORDS="-* arm"
IUSE="+pcserial"

DEPEND=""

# TODO(jrbarnette):  The sys-boot/u-boot package is meant to have a
# short lifetime; we'd rather depend on the Chrome OS U-Boot
# infrastructure.  http://crbug.com/302022
RDEPEND="
	pcserial? ( chromeos-base/serial-tty )
	chromeos-base/u-boot-scripts
	sys-boot/u-boot
"
