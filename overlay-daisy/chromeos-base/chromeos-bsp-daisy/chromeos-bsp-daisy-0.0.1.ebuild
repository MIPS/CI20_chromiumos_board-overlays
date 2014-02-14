# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid toolchain-funcs udev

DESCRIPTION="Daisy public bsp (meta package to pull in driver/tool dependencies)"

LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE="-spring -snow -skate -samsung_serial"

DEPEND="
	!<chromeos-base/chromeos-bsp-spring-private-0.0.1-r16
	!<chromeos-base/chromeos-bsp-daisy-private-0.0.1-r27
	!chromeos-base/light-sensor
"
RDEPEND="${DEPEND}
	snow? ( chromeos-base/chromeos-init chromeos-base/thermal )
	spring? ( chromeos-base/chromeos-init chromeos-base/thermal )
	samsung_serial? ( chromeos-base/serial-tty )
	chromeos-base/default-zram-size
	media-libs/media-rules
	media-libs/mfc-fw
	sys-boot/exynos-pre-boot
	x11-drivers/mali-rules
	x11-drivers/xf86-video-armsoc
"

S=${WORKDIR}

src_install() {
	# Install the proper appid depending on the board being built.
	# This would normally be done with board_use_$BOARD USE flags.
	if use spring; then
		# Have to check spring first since it's a superset of snow.
		doappid "{ADA16F7B-283C-4907-AE27-ABBF5CA4F7F1}"
	elif use snow; then
		doappid "{D851316B-7E57-4805-A7CE-01829AC1443E}"
	fi

	# Install platform-specific ambient light sensor configuration.
	udev_dorules "${FILESDIR}/99-light-sensor.rules"
	exeinto $(udev_get_udevdir)
	doexe "${FILESDIR}/light-sensor-set-multiplier.sh"

	# Install platform specific config files for power_manager.
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}/battery_poll_short_interval_ms"
	doins "${FILESDIR}/low_battery_shutdown_percent"
	doins "${FILESDIR}/low_battery_shutdown_time_s"
	if use spring; then
		newins "${FILESDIR}/wakeup_input_device_names_spring" "wakeup_input_device_names"
	elif use snow; then
		newins "${FILESDIR}/wakeup_input_device_names_snow" "wakeup_input_device_names"
	elif use skate; then
		newins "${FILESDIR}/wakeup_input_device_names_skate" "wakeup_input_device_names"
	fi

	# Install platform specific usb device list for laptop mode tools
	insinto "/etc/laptop-mode/conf.d/board-specific"
	doins "${FILESDIR}/cpufreq.conf"
	doins "${FILESDIR}/runtime-pm.conf"

	if use snow || use spring; then
		udev_dorules "${FILESDIR}/50-rtc.rules"
	fi

	# Install platform specific upstart jobs
	insinto /etc/init
	doins "${FILESDIR}/send-asv-metrics.conf"
}
