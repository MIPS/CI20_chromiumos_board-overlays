# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT=("406eab3ca6a9bc59382866817786bf96bbb19d56" "04171532583052935121a3e33550cc39ef2625ec")
CROS_WORKON_TREE=("d0e1ad569ff9c5dbe64d95a213f6acb6a43c3b8b" "9e8b9350d8c2e16a9114150a552e97604340cb49")
CROS_WORKON_PROJECT=("chromiumos/third_party/coreboot" "chromiumos/platform/vboot_reference")
CROS_WORKON_LOCALNAME=("coreboot" "../platform/vboot_reference")
CROS_WORKON_DESTDIR=("${S}" "${S}/vboot_reference")

inherit cros-board cros-workon cros-coreboot

KEYWORDS="arm"

DEPEND="dev-embedded/cbootimage"

RDEPEND="chromeos-base/vboot_reference"
