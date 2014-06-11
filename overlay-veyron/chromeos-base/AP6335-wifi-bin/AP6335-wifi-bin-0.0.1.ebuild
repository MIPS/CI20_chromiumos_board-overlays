# Copyright 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="This is the wifi firmware binary for AP6335"

inherit cros-binary

CROS_BINARY_URI="https://github.com/rkchrome/wifi_fw_bcm/archive/${P}.tar.gz"
CROS_BINARY_INSTALL_FLAGS="--strip-components=1"

LICENSE="Google-TOS"
SLOT="0"
KEYWORDS="-* arm"
IUSE=""

RDEPEND=""
DEPEND=""
S=${WORKDIR}
