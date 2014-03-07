# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT=("462e61ad898a4d6a99c1d161d77bde245c5b1f5c" "b5a8ca7e5cac7c4559cc928abc02db3cb8799946")
CROS_WORKON_TREE=("6d45a1be54eba05bfc90474be0e7dc4a8df3a3fa" "6c72197cede19ee70ccd896753c3c5d8aed75d43")
CROS_WORKON_PROJECT=("chromiumos/third_party/coreboot" "chromiumos/third_party/coreboot/blobs")
CROS_WORKON_LOCALNAME=("coreboot" "coreboot/3rdparty")
CROS_WORKON_DESTDIR=("${S}" "${S}/3rdparty")

inherit cros-board cros-workon cros-coreboot

KEYWORDS="arm"

RDEPEND="!sys-boot/chromeos-coreboot"
