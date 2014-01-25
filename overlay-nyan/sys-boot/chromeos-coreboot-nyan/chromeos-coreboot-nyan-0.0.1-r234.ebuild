# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT=("89cbd15c951737a8f8cd48ee5ccbb967b8f622d9" "a53a0b040f45a1086515e7a5c8a8326c0b1d1f74")
CROS_WORKON_TREE=("8d4c68e99076edc5c8b6029e59f9b18cc576e44c" "080214e3c0574eaeac8d0e4f8e708831e3f379e7")
CROS_WORKON_PROJECT=("chromiumos/third_party/coreboot" "chromiumos/platform/vboot_reference")
CROS_WORKON_LOCALNAME=("coreboot" "../platform/vboot_reference")
CROS_WORKON_DESTDIR=("${S}" "${S}/vboot_reference")

inherit cros-board cros-workon cros-coreboot

KEYWORDS="arm"

DEPEND="dev-embedded/cbootimage"

RDEPEND="chromeos-base/vboot_reference"
