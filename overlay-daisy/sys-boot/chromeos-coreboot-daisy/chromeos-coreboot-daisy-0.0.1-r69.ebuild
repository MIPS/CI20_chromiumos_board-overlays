# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT=("00a3b46eedb3051caaee7ec3aa39dbe1dfcb48e7" "b5a8ca7e5cac7c4559cc928abc02db3cb8799946")
CROS_WORKON_TREE=("7fabec94a103115ecd2d62405395cde6e52db7f3" "6c72197cede19ee70ccd896753c3c5d8aed75d43")
CROS_WORKON_PROJECT=("chromiumos/third_party/coreboot" "chromiumos/third_party/coreboot/blobs")
CROS_WORKON_LOCALNAME=("coreboot" "coreboot/3rdparty")
CROS_WORKON_DESTDIR=("${S}" "${S}/3rdparty")

inherit cros-board cros-workon cros-coreboot

KEYWORDS="arm"

RDEPEND="!sys-boot/chromeos-coreboot"
