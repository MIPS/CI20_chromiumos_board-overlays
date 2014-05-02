# Copyright 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

DESCRIPTION="ebuild which satisfies virtual/chromeos-bootcomplete.

This depends on the package that emits the boot-complete signal."
HOMEPAGE="http://src.chromium.org"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
RDEPEND="chromeos-base/app-shell-launcher"
DEPEND="${RDEPEND}"
