# Copyright 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

DESCRIPTION="ebuild which satisifies virtual/chromeos-interface.

This depends on packages needed for a user to interact with the system."
HOMEPAGE="http://src.chromium.org"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
RDEPEND="chromeos-base/app-shell-launcher"
DEPEND="${RDEPEND}"
