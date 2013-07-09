# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Virtual for OpenGLES implementations"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE="tegra-ldk"

RDEPEND="
	!tegra-ldk? ( x11-drivers/opengles )
	tegra-ldk? ( x11-drivers/opengles-bin )
	"
DEPEND=""
