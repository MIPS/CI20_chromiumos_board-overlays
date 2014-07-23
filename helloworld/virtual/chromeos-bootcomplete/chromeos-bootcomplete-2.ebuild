# Copyright 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Virtual package installing the boot-complete boot marker.
For the helloworld app, the main application provides the boot marker and is
installed by chromeos-bsp/helloworldapp"

HOMEPAGE="https://sites.google.com/a/chromium.org/dev/chromium-os/boot-complete-conf"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND="app-misc/helloworld"
