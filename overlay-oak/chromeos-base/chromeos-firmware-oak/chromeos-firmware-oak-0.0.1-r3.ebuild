# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT="1433c0b63a49057877a56b3ed3e33dc20fc389fa"
CROS_WORKON_TREE="9d4dbad9cc65cfd8e01b01a2f47ea2226ab71bb0"
CROS_WORKON_LOCALNAME="firmware"
CROS_WORKON_PROJECT="chromiumos/platform/firmware"

inherit cros-workon cros-firmware

DESCRIPTION="Chrome OS Firmware for Oak"
HOMEPAGE="http://src.chromium.org"
LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"

# MTK special preloaders.
MTK_LOADER_VERSION="0.0.1"
MTK_LOADER_DIR="chromiumos-third_party-mediatek-firmware"
MTK_LOADER_ARCHIVE_NAME="${PN}-${MTK_LOADER_VERSION}.tar.gz"
MTK_LOADER_ARCHIVE_PATH="${MTK_LOADER_DIR}/archive/${MTK_LOADER_ARCHIVE_NAME}"
MTK_LOADER_LOCAL_DIR="${MTK_LOADER_DIR}-${PN}-${MTK_LOADER_VERSION}"
SRC_URI="https://github.com/mtk09422/${MTK_LOADER_ARCHIVE_PATH}"

# Remove other virtual packages
RDEPEND="
	!chromeos-base/chromeos-firmware-null
"

# ---------------------------------------------------------------------------
# CUSTOMIZATION SECTION

# Default firmware image files.
# To use the Binary Component Server (BCS), copy a tbz2 archive to CPFE:
#   http://www.google.com/chromeos/partner/fe/
# This archive should contain only the image file at its root.
# Examples
#  CROS_FIRMWARE_MAIN_IMAGE="bcs://filename.tbz2" - Fetch from BCS.
#  CROS_FIRMWARE_MAIN_IMAGE="${ROOT}/firmware/filename.bin" - Local file path.

# When you modify any files below, please also update manifest file in chroot:
#  ebuild-$board chromeos-firmware-$board-9999.ebuild manifest
CROS_FIRMWARE_MAIN_IMAGE=""
CROS_FIRMWARE_EC_IMAGE=""

# Stable firmware settings. Devices with firmware version smaller than stable
# version (or if stable version is empty) will get RO+RW update if write
# protection is not enabled.
CROS_FIRMWARE_STABLE_MAIN_VERSION=""
CROS_FIRMWARE_STABLE_EC_VERSION=""

# Updater configurations
CROS_FIRMWARE_SCRIPT="updater5.sh"

cros-firmware_setup_source

src_unpack() {
	cros-firmware_src_unpack
	unpack ../distdir/"${MTK_LOADER_ARCHIVE_NAME}"
}

src_install() {
	cros-firmware_src_install
	insinto /firmware/prebuilt
	doins "${WORKDIR}/${MTK_LOADER_LOCAL_DIR}"/firmware/*
}
