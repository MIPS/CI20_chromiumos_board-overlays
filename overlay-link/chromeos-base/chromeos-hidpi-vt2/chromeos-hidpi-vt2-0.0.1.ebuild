# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

EAPI="4"

DESCRIPTION="Virtual terminal font setting for high resolution screen"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm x86"

DEPEND=""
RDEPEND="sys-apps/kbd"

S=${WORKDIR}

src_install() {
	insinto /etc/init
	doins "${FILESDIR}"/vt2-font.conf
}
