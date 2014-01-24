# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT=("6cccf5830b0d787da6725f7bf1c3c9ac6df6d109" "a53a0b040f45a1086515e7a5c8a8326c0b1d1f74")
CROS_WORKON_TREE=("63a622da3317f7be5b3814e8200b7209d8d6be26" "080214e3c0574eaeac8d0e4f8e708831e3f379e7")
CROS_WORKON_PROJECT=("chromiumos/third_party/coreboot" "chromiumos/platform/vboot_reference")
CROS_WORKON_LOCALNAME=("coreboot" "../platform/vboot_reference")
CROS_WORKON_DESTDIR=("${S}" "${S}/vboot_reference")

inherit cros-board cros-workon cros-coreboot

KEYWORDS="arm"

DEPEND="dev-embedded/cbootimage"

RDEPEND="chromeos-base/vboot_reference"
