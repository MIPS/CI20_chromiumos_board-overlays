# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit appid

DESCRIPTION="Board-specific packages for ZGB"
HOMEPAGE="http://src.chromium.org"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

# Ericsson support.
RDEPEND="${RDEPEND}
	virtual/modemmanager
"

# Chrontel support.
RDEPEND="${RDEPEND}
	chromeos-base/chrontel
"

# ChromeOS board support.
RDEPEND="${RDEPEND}
	app-laptop/laptop-mode-tools
	chromeos-base/light-sensor
	chromeos-base/vpd
	sys-apps/iotools
"

S=${WORKDIR}

src_install() {
	doappid "{23F5C60F-7655-4BF4-90FB-BFDE16408308}"
}
