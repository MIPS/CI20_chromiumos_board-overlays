# Copyright 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="app-shell board-specific package"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE=""
S=${WORKDIR}

DEPEND=""
RDEPEND="
	chromeos-base/app-shell-launcher
	chromeos-base/buffet
	net-misc/openssh
"
