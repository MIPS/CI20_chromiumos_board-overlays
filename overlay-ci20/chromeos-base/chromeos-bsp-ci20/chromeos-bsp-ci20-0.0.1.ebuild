# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="CI20 bsp (meta package to pull in driver/tool dependencies)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* mips"
IUSE=""

RDEPEND="sys-boot/ci20-u-boot"
