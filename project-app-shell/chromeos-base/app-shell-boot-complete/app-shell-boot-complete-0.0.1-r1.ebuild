# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can
# be found in the LICENSE file.

EAPI="4"

DESCRIPTION="boot complete signal for app_shell based systems"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"

S=${WORKDIR}

src_install() {
	insinto /etc/init
	doins "${FILESDIR}/boot-complete.conf"
}
