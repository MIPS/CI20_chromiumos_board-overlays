# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT=("11cf72bf5de457dc7710b1d1418882544642c5ab" "435be9873179338d0c4e7b2d823989181a089771")
CROS_WORKON_TREE=("462391a4706d5a57d990e7a85b0debff8015f93e" "543684777aa560b9204d462d64770c6e209c4083")
CROS_WORKON_PROJECT=("chromiumos/third_party/coreboot" "chromiumos/platform/vboot_reference")
CROS_WORKON_LOCALNAME=("coreboot" "../platform/vboot_reference")
CROS_WORKON_DESTDIR=("${S}" "${S}/vboot_reference")

inherit cros-board cros-workon cros-coreboot

KEYWORDS="arm"

DEPEND="dev-embedded/cbootimage"

RDEPEND="chromeos-base/vboot_reference"
