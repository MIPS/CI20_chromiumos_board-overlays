# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

DESCRIPTION="The scripts for stumpy specific OEM customization"
HOMEPAGE="http://src.chromium.org"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S=${WORKDIR}

OEM_DIR=/opt/oem
ASSETS_DIR=/usr/share/chromeos-assets

src_install() {
	insinto "${OEM_DIR}"
	doins -r "${FILESDIR}"/etc
}
