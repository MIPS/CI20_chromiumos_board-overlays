# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid cros-board

DESCRIPTION="Nyan bsp (meta package to pull in driver/tool dependencies)"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="arm"
IUSE="opengles tegra-ldk"

DEPEND="sys-boot/chromeos-bootimage"
RDEPEND="
	sys-kernel/tegra_lp0_resume
	tegra-ldk? (
		opengles? ( media-libs/openmax media-libs/openmax-codecs )
		x11-drivers/tegra-drivers
	)
	sys-apps/daisydog
"

S=${WORKDIR}

src_install() {
	# Variants of nyan will have their own appids
	local board=$(get_current_board_with_variant)
	if [[ "$board" = "nyan" ]]; then
		doappid "{334FF5FA-CEE5-7688-1C73-78CE7F5B24A9}"
	fi

	# Override default CPU clock speed governor
	insinto "/etc/laptop-mode/conf.d/board-specific"
	doins "${FILESDIR}/cpufreq.conf"
	# Enable the Tegra CPU auto-hotplug feature
	insinto "/etc/laptop-mode/conf.d/board-specific"
	doins "${FILESDIR}/nv-cpu-auto-hotplug.conf"
	exeinto "/usr/share/laptop-mode-tools/modules"
	doexe "${FILESDIR}/nv-cpu-auto-hotplug"

	# Install platform specific config files for power_manager.
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}/min_visible_backlight_level"
	doins "${FILESDIR}/wakeup_input_device_names"
}
