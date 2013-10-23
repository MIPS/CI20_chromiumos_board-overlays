# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit appid

DESCRIPTION="Ebuild which pulls in any necessary ebuilds as dependencies
or portage actions."

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

# Add dependencies on other ebuilds from within this board overlay
RDEPEND="chromeos-base/chromeos-board-info-link
	chromeos-base/ca0132-dsp-firmware
	chromeos-base/ec-utils
	chromeos-base/light-sensor
	chromeos-base/lte-quirks
	chromeos-base/temp-metrics
"
DEPEND="${RDEPEND}"

S=${WORKDIR}

src_install() {
	doappid "{F26D159B-52A3-491A-AE25-B23670A66B32}"

	# Install platform specific config file for power_manager
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}/instant_transitions_below_min_level"
	doins "${FILESDIR}/keyboard_backlight_als_limits"
	doins "${FILESDIR}/keyboard_backlight_als_steps"
	doins "${FILESDIR}/keyboard_backlight_user_limits"
	doins "${FILESDIR}/keyboard_backlight_user_steps"
	doins "${FILESDIR}/low_battery_shutdown_percent"
	doins "${FILESDIR}/low_battery_shutdown_time_s"
	doins "${FILESDIR}/min_visible_backlight_level"
	doins "${FILESDIR}/plugged_brightness_offset"
	doins "${FILESDIR}/unplugged_brightness_offset"
	doins "${FILESDIR}/wakeup_input_device_names"
	doins "${FILESDIR}/dark_resume_suspend_durations"
	doins "${FILESDIR}/dark_resume_devices"
	doins "${FILESDIR}/dark_resume_sources"
	doins "${FILESDIR}/dark_resume_battery_margins"

	exeinto "/opt/google/touch"
	doexe "${FILESDIR}/touch-control.sh"

	# Install board-specific info.
	insinto "/etc/laptop-mode/conf.d/board-specific"
	doins "${FILESDIR}/cpufreq.conf"
}
