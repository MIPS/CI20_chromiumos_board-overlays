# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT="b5e10ad47b9e4f330caaee4faf69702f24d6bdd8"
CROS_WORKON_TREE="f4944fddb7ec859297e6609076b701bac5b8b817"
CROS_WORKON_PROJECT="chromiumos/third_party/coreboot"
CROS_WORKON_LOCALNAME="coreboot"

inherit cros-board cros-workon cros-coreboot

KEYWORDS="arm"

RDEPEND="!sys-boot/chromeos-coreboot"
