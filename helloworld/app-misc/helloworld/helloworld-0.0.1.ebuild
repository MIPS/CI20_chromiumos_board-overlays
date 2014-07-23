# Copyright 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="A very nice conversation bot."

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE=""

S="${WORKDIR}"

src_unpack() {
	cp "${FILESDIR}"/* "${WORKDIR}/"
}

src_compile() {
	emake OUTPUT="${WORKDIR}/helloworld"
}

src_install() {
	dobin "${WORKDIR}"/helloworld

	insinto /etc/init
	doins boot-complete.conf
}
