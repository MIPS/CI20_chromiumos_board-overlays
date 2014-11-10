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

# TODO (sbasi) - Remove test keys once proper ssh key installation flow is
# determined.
RDEPEND="${RDEPEND}
	chromeos-base/chromeos-test-testauthkeys"

# Mobbuild Deps.
RDEPEND="${RDEPEND}
	app-crypt/gnupg
	dev-libs/protobuf
	dev-python/mysql-python
	dev-python/sqlalchemy
	dev-vcs/git
	dev-vcs/repo
"

DEPEND=""

S=${WORKDIR}

pkg_setup() {
	enewgroup mobbuild
	enewuser mobbuild
}

src_install(){
	insinto /etc/init
	doins "${FILESDIR}"/init/*.conf

	insinto /etc/sudoers.d
	echo "mobbuild ALL=NOPASSWD: ALL" > mobbuild-all
	insopts -m600
	doins mobbuild-all
}
