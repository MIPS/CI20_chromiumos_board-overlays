# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Install configuration data for Atmel chips"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="${DEPEND}
	 chromeos-base/touch_updater"

TOUCH_CONFIG_PATH="/opt/google/touch/config"
TP_CONFIG_FILE="224sl.raw"
TP_CONFIG_LINK="/lib/firmware/maxtouch-tp.cfg"

S=${WORKDIR}

src_install() {
	insinto "${TOUCH_CONFIG_PATH}"
	doins "${FILESDIR}/${TP_CONFIG_FILE}"
	dosym "${TOUCH_CONFIG_PATH}/${TP_CONFIG_FILE}" "${TP_CONFIG_LINK}"
}
