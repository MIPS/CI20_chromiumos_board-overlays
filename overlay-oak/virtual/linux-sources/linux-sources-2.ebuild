# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

DESCRIPTION="Chrome OS Kernel virtual package"
HOMEPAGE="http://src.chromium.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* arm64 arm"

IUSE="-kernel_sources"

RDEPEND="
	sys-kernel/kernel-mediatek[kernel_sources=]
"
