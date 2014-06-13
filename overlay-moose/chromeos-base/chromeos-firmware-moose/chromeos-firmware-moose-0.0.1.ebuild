# Copyright (c) 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Little kernel Binary for moose"

inherit cros-binary

CROS_BINARY_URI="https://github.com/mtk00874/kernel-lk/archive/${P}.tar.gz"
CROS_BINARY_INSTALL_FLAGS="--strip-components=1"

LICENSE="BSD"
SLOT="0"
KEYWORDS="-* arm"
IUSE=""

RDEPEND=""
DEPEND=""
S=${WORKDIR}
