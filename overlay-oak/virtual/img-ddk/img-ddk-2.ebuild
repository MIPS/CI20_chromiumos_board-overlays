# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Virtual for img-ddk packages (source or prebuilt binaries)"
SRC_URI=""

SLOT="0"
KEYWORDS="-* arm"

DEPEND="
	media-libs/img-ddk-bin
"
RDEPEND="${DEPEND}"
