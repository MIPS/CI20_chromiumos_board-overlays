# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Nyan bsp (meta package to pull in driver/tool dependencies)"

LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE="opengles tegra-ldk"

DEPEND="sys-boot/chromeos-bootimage"
RDEPEND="
	chromeos-base/serial-tty
	tegra-ldk? (
		opengles? ( media-libs/openmax media-libs/openmax-codecs )
		x11-drivers/tegra-drivers
	)
"

S=${WORKDIR}

src_install() {
	# Override default CPU clock speed governor
	insinto "/etc/laptop-mode/conf.d/board-specific"
	doins "${FILESDIR}/cpufreq.conf"
	# Enable the Tegra CPU auto-hotplug feature
	insinto "/etc/laptop-mode/conf.d/board-specific"
	doins "${FILESDIR}/nv-cpu-auto-hotplug.conf"
	exeinto "/usr/share/laptop-mode-tools/modules"
	doexe "${FILESDIR}/nv-cpu-auto-hotplug"
}
