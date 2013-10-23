# Copyright (c) The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

EAPI="4"

DESCRIPTION="Workaround for LTE modem malfunction resuming from autosuspend"
HOMEPAGE="http://www.chromium.org/"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE=""

# This says that I have no source and I am OK with it.
S=${WORKDIR}

src_install() {
	exeinto "/usr/sbin"
	doexe "${FILESDIR}/lte-quirks.sh"
	insinto "/etc/udev/rules.d"
	doins "${FILESDIR}/99-lte-quirks.rules"
}
