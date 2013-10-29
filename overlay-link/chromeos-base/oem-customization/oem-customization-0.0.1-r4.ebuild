# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

DESCRIPTION="The scripts for Link specific OEM customization."
HOMEPAGE="http://src.chromium.org"
SRC_URI=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND=""
RDEPEND=""

ASSETS_DIR=/usr/share/chromeos-assets

src_install() {
	insinto "${ASSETS_DIR}"/genius_app/offline_device_specific
	doins -r "${FILESDIR}"/genius_app/*
}
