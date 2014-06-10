# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Chrome OS Kernel virtual package"
HOMEPAGE="http://src.chromium.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="arm"
IUSE="-kernel_sources"

RDEPEND="
	sys-kernel/kernel-beaglebone[kernel_sources=]
"
