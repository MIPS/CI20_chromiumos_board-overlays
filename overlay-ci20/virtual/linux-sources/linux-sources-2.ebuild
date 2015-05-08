# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

DESCRIPTION="Chrome OS Kernel virtual package"
HOMEPAGE="http://src.chromium.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="mips"

IUSE=""

# This will use the 'latest' kernel in the ci20-kernel directory
RDEPEND="sys-kernel/ci20-kernel"

# Comment the above line and uncomment this one to use the 3.0.8 kernel
#RDEPEND="~sys-kernel/ci20-kernel-3.0.8"
