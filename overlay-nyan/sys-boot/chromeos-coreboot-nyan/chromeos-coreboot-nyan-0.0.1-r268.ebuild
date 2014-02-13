# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT=("8e7014f24a580f84c91fa7b0369dfa922918adcc" "e8117120b677937902fc3c75ba3cee97e1fa0dc1")
CROS_WORKON_TREE=("6195207040da1da304c53595367fc47368342c9b" "64d60fe5825ea24dd2260722f923b6d1620af58d")
CROS_WORKON_PROJECT=("chromiumos/third_party/coreboot" "chromiumos/platform/vboot_reference")
CROS_WORKON_LOCALNAME=("coreboot" "../platform/vboot_reference")
CROS_WORKON_DESTDIR=("${S}" "${S}/vboot_reference")

inherit cros-board cros-workon cros-coreboot

KEYWORDS="arm"

DEPEND="dev-embedded/cbootimage"

RDEPEND="chromeos-base/vboot_reference"
