# Copyright 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit user

DESCRIPTION="Ebuild which pulls in any necessary ebuilds as dependencies or portage actions"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE=""

# These packages are meant to set up the Chromium OS Basic environment to
# properly handle the services required by mobbuild.
RDEPEND=""

DEPEND=""

S=${WORKDIR}

pkg_setup() {
	enewgroup mobbuild
	enewuser mobbuild
}
