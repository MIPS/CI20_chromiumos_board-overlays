# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT=("f2fab7383ee5352dab2d5f2b8a7d2d321d5944bc" "4ff446b493e8a74804fd00082119681f768d366a")
CROS_WORKON_TREE=("cde9bf2833cc0fd7136be320152838ffa749f62c" "b281140056b5518723b0553778c0f409d1c3b010")
CROS_WORKON_PROJECT=("chromiumos/third_party/coreboot" "chromiumos/platform/vboot_reference")
CROS_WORKON_LOCALNAME=("coreboot" "../platform/vboot_reference")
CROS_WORKON_DESTDIR=("${S}" "${S}/vboot_reference")

inherit cros-board cros-workon cros-coreboot

KEYWORDS="arm"

DEPEND="dev-embedded/cbootimage"

RDEPEND="chromeos-base/vboot_reference"
