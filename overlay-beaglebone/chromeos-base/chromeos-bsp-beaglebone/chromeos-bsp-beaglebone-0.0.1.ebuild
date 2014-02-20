# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

DESCRIPTION="Beaglebone bsp (meta package to pull in driver/tool dependencies)"

LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE=""

DEPEND=""

# Mission critical dependencies; these are included because
# they're basic requirements for operation in the Chrome OS
# test lab:
#     chromeos-base/openssh-server-init - upstart job to start
#       sshd at boot time.
#     chromeos-base/chromeos-test-testauthkeys - install Chromium OS
#       test key to /root/.ssh/authorized_keys.
#     chromeos-base/serial-tty - upstart job to start agetty
#       for console login.
#     chromeos-base/u-boot-scripts - Chrome OS bootstrap support for
#       partition selection during autoupdate.
#     dev-util/hdctools - servod support.
#     net-misc/openssh - ssh client, sshd server, and related tools.
#     sys-boot/u-boot - Beaglebone bootstrap code.
#
# TODO(jrbarnette):  The sys-boot/u-boot package is meant to have a
# short lifetime; we'd rather depend on the Chrome OS U-Boot
# infrastructure.  http://crbug.com/302022
RDEPEND="
	chromeos-base/chromeos-test-testauthkeys
	chromeos-base/openssh-server-init
	chromeos-base/serial-tty
	chromeos-base/u-boot-scripts
	dev-util/hdctools
	net-misc/openssh
	sys-apps/flashrom
	sys-boot/u-boot
"

# These packages are meant to provide a basic environment for
# developers that need to log in to a device for purposes of
# debugging and/or resolving problems.
#
# You should be generous with this list:  We're not (currently)
# space constrained, so if you think it might be useful, include it.
RDEPEND="${RDEPEND}
	app-arch/gzip
	app-editors/vim
	app-misc/screen
	app-shells/bash
	dev-util/strace
	net-analyzer/tcpdump
	net-misc/iputils
	net-misc/rsync
	sys-apps/diffutils
	sys-apps/file
	sys-apps/i2c-tools
	sys-apps/less
	sys-apps/usbutils
	sys-kernel/linux-firmware
	sys-process/procps
	sys-process/psmisc
	sys-process/time
"
