# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Install configuration data for Atmel chips"

LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE=""

TOUCH_CONFIG_PATH="/opt/google/touch/config"
TP_CONFIG_FILE="336s.raw"
TP_CONFIG_LINK="/lib/firmware/maxtouch-tp.cfg"

S=${WORKDIR}

DEPEND=""

RDEPEND="${DEPEND}
	 chromeos-base/touch_updater"

src_install() {
	insinto "${TOUCH_CONFIG_PATH}"
	doins "${FILESDIR}/${TP_CONFIG_FILE}"
	dosym "${TOUCH_CONFIG_PATH}/${TP_CONFIG_FILE}" "${TP_CONFIG_LINK}"
}
