# Copyright (c) 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

DESCRIPTION="Install the upstart jobs that install a firewall with only forwarding disabled."
HOMEPAGE="http://www.chromium.org/"
LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"

S=${WORKDIR}

RDEPEND="
	chromeos-base/chromeos-init
	net-firewall/iptables[ipv6]
"

src_install() {
	insinto /etc/init
	doins "${FILESDIR}"/*.conf || die
}
