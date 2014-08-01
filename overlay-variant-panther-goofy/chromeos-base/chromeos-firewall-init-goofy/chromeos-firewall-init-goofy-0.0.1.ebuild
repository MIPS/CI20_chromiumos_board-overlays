# Copyright 2014 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

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
