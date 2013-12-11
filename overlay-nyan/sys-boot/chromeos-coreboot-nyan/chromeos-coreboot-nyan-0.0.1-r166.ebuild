# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT=("4f819e85490ccc3d7c141ecfabe17bc2aec5563d" "8912169231e589b0400debed26f9cedbbe6d9561")
CROS_WORKON_TREE=("ed55fc27965ea6b4c56f4a7ee66391cbdb518752" "aad2329c93c5271a679e385b6fa94b7792c56b69")
CROS_WORKON_PROJECT=("chromiumos/third_party/coreboot" "chromiumos/platform/vboot_reference")
CROS_WORKON_LOCALNAME=("coreboot" "../platform/vboot_reference")
CROS_WORKON_DESTDIR=("${S}" "${S}/vboot_reference")

COREBOOT_BOARD="nyan"
COREBOOT_BOARD_ROOT="google/nyan"
COREBOOT_BUILD_ROOT="builds/nyan"

inherit cros-board cros-workon cros-coreboot

KEYWORDS="arm"

DEPEND="dev-embedded/cbootimage"

RDEPEND="chromeos-base/vboot_reference"
