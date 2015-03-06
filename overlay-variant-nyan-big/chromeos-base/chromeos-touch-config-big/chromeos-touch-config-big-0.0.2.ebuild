# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Install configuration data for Atmel chips"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	 chromeos-base/touch_updater"

S=${WORKDIR}

src_install() {
	local touch_config_path="/opt/google/touch/config"
	local ts_config_file="2952t.raw"
	local ts_config_link="/lib/firmware/maxtouch-ts.cfg"

	insinto "${touch_config_path}"
	doins "${FILESDIR}/${ts_config_file}"
	dosym "${touch_config_path}/${ts_config_file}" "${ts_config_link}"
}
