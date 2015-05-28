# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Virtual for OpenGLES implementations"

SLOT="0"
KEYWORDS="-* arm"
IUSE=""

DEPEND="
	virtual/img-ddk
	media-libs/mesa-img
"
RDEPEND="${DEPEND}"
