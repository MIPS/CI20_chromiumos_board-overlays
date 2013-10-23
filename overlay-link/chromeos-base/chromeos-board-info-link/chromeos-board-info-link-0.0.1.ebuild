# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit toolchain-funcs

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="chromeos-base/userfeedback"
DEPEND="${RDEPEND}"

S=${WORKDIR}

src_unpack() {
	cp -a "${FILESDIR}/get_monotonic_time.c" "${S}" || die
}

src_compile() {
	emake CC="$(tc-getCC)" LDLIBS="-lrt" get_monotonic_time
}

src_install() {
	dosbin "${FILESDIR}"/get_touch_noise_log.sh get_monotonic_time
	exeinto /usr/share/userfeedback/scripts
	doexe "${FILESDIR}"/get_board_specific_info
}
