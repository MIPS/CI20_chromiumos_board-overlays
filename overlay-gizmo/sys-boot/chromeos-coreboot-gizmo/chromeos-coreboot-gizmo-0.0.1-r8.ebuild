# Copyright (c) 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT=("5bba447654417c42952c49542ed047b4867d04d1" "b5a8ca7e5cac7c4559cc928abc02db3cb8799946")
CROS_WORKON_TREE=("c3b846846024b611596485725b4df13ea92ed56e" "6c72197cede19ee70ccd896753c3c5d8aed75d43")
CROS_WORKON_PROJECT=("chromiumos/third_party/coreboot" "chromiumos/third_party/coreboot/blobs")
CROS_WORKON_LOCALNAME=("coreboot" "coreboot/3rdparty")
CROS_WORKON_DESTDIR=("${S}" "${S}/3rdparty")

inherit cros-board cros-workon cros-coreboot

KEYWORDS="amd64 x86"

RDEPEND="!sys-boot/chromeos-coreboot"
