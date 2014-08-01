# Copyright 2014 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

EAPI=4

inherit appid

DESCRIPTION="Ebuild which pulls in any necessary ebuilds as dependencies
or portage actions."

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
S="${WORKDIR}"

# Add dependencies on other ebuilds from within this board overlay
# Panther itself requires no special firmware, but we modify panthers
# to add WiFi parts that require firmware when building test APs.
RDEPEND="
	sys-kernel/linux-firmware
"

RDEPEND="${RDEPEND}
	chromeos-base/chromeos-factory-server
"

DEPEND="${RDEPEND}"

src_install() {
        doappid "{11593DCB-0224-4047-8158-138ACA460A7F}"
}
