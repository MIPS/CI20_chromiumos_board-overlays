# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Install configuration data for Atmel chips"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND="chromeos-base/touch_updater"

S=${WORKDIR}

src_install() {
	local touch_config_path="/opt/google/touch/config"

	insinto "${touch_config_path}"

	local config_file="337t.raw"
	local config_link="/lib/firmware/maxtouch-tp.cfg"

	doins "${FILESDIR}/${config_file}"
	dosym "${touch_config_path}/${config_file}" "${config_link}"

	local config_file="2954t2.raw"
	local config_link="/lib/firmware/maxtouch-ts.cfg"

	doins "${FILESDIR}/${config_file}"
	dosym "${touch_config_path}/${config_file}" "${config_link}"
}
