# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

CROS_WORKON_REPO="https://chrome-internal.googlesource.com"
CROS_WORKON_PROJECT="chromeos/vendor/kernel-mediatek"
CROS_WORKON_LOCALNAME="../partner_private/kernel-mediatek"
CROS_WORKON_BLACKLIST="1"

# This must be inherited *after* EGIT/CROS_WORKON variables defined
inherit cros-workon cros-kernel2

DESCRIPTION="Mediatek Chrome OS Kernel"

LICENSE="GPL-2"
KEYWORDS="~*"

DEPEND="!sys-kernel/chromeos-kernel"
RDEPEND="${DEPEND}"
