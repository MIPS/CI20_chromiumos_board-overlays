# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT=("49f5be75bd7b08614c09ecc1da8e412d1bdeeab1" "4ff446b493e8a74804fd00082119681f768d366a")
CROS_WORKON_TREE=("dff9ca9dcd37fda8b298577c8648fc9b1984d2d7" "b281140056b5518723b0553778c0f409d1c3b010")
CROS_WORKON_PROJECT=("chromiumos/third_party/coreboot" "chromiumos/platform/vboot_reference")
CROS_WORKON_LOCALNAME=("coreboot" "../platform/vboot_reference")
CROS_WORKON_DESTDIR=("${S}" "${S}/vboot_reference")

inherit cros-board cros-workon cros-coreboot

KEYWORDS="arm"

DEPEND="dev-embedded/cbootimage"

RDEPEND="chromeos-base/vboot_reference"
