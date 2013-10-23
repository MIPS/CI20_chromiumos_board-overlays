# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Ebuild which pulls in any necessary ebuilds as dependencies
or portage actions."

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
PROVIDE="virtual/chromeos-bsp-dev"

# Add dependencies on other ebuilds from within this board overlay
RDEPEND="chromeos-base/chromeos-hidpi-vt2"
DEPEND="${RDEPEND}"
