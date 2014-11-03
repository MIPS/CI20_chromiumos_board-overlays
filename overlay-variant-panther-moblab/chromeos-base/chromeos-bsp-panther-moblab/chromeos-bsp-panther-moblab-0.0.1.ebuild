# Copyright 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit appid

DESCRIPTION="Ebuild which pulls in any necessary ebuilds as dependencies or portage actions"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""

S=${WORKDIR}

src_install() {
	doappid "{0A54D104-EC0D-450D-8588-FB106B2C6703}"
}
