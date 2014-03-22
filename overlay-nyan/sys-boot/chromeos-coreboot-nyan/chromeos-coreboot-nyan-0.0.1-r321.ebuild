# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT=("6261a462c8eb05320c9580f2836c2aa94bcd6ed0" "4ff446b493e8a74804fd00082119681f768d366a")
CROS_WORKON_TREE=("4932a6d8e04a66d92dd7a9b3ba081c50ddfe0e29" "b281140056b5518723b0553778c0f409d1c3b010")
CROS_WORKON_PROJECT=("chromiumos/third_party/coreboot" "chromiumos/platform/vboot_reference")
CROS_WORKON_LOCALNAME=("coreboot" "../platform/vboot_reference")
CROS_WORKON_DESTDIR=("${S}" "${S}/vboot_reference")

inherit cros-board cros-workon cros-coreboot

KEYWORDS="arm"

DEPEND="dev-embedded/cbootimage"

RDEPEND="chromeos-base/vboot_reference"
