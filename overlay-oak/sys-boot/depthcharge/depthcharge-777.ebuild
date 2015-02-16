# Copyright 2015 The Chromium OS Authors.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_PROJECT=(
	"chromiumos/platform/vboot_reference"
)

DESCRIPTION="coreboot's depthcharge payload"
HOMEPAGE="http://www.coreboot.org"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* arm"
IUSE="ap148-mode fwconsole mocktpm pd_sync unified_depthcharge vboot2"

RDEPEND="
	sys-apps/coreboot-utils
	sys-boot/libpayload
	chromeos-base/vboot_reference
	"
DEPEND=${RDEPEND}

CROS_WORKON_LOCALNAME=("../platform/vboot_reference")
VBOOT_REFERENCE_DESTDIR="${S}/vboot_reference"
CROS_WORKON_DESTDIR=("${VBOOT_REFERENCE_DESTDIR}")

# Don't strip to ease remote GDB use (cbfstool strips final binaries anyway)
STRIP_MASK="*"
CROS_WORKON_BLACKLIST="1"

inherit cros-workon cros-board toolchain-funcs git-2

src_unpack() {
	EGIT_REPO_URI="https://github.com/mtk09422/chromiumos-platform-depthcharge.git"
	EGIT_BRANCH="tot-oak"
	EGIT_COMMIT="tot-oak"

	git-2_src_unpack
	cros-workon_src_unpack
}

src_configure() {
	cros-workon_src_configure
}

src_compile() {
	local board=$(get_current_board_with_variant)
	if [[ ! -d "board/${board}" ]]; then
		board=$(get_current_board_no_variant)
	fi

	tc-getCC

	# Firmware related binaries are compiled with a 32-bit toolchain
	# on 64-bit platforms
	if use amd64 ; then
		export CROSS_COMPILE="i686-pc-linux-gnu-"
		export CC="${CROSS_COMPILE}gcc"
	else
		export CROSS_COMPILE=${CHOST}-
	fi

	if use mocktpm || use ap148-mode; then
		echo "CONFIG_MOCK_TPM=y" >> "board/${board}/defconfig"
	fi
	if use fwconsole ; then
		echo "CONFIG_CLI=y" >> "board/${board}/defconfig"
		echo "CONFIG_SYS_PROMPT=\"${board}: \"" >>  \
		  "board/${board}/defconfig"
	fi
	if use vboot2; then
		echo "CONFIG_VBOOT2_VERIFY_FIRMWARE=y" >> \
		  "board/${board}/defconfig"
	fi

	emake distclean
	emake defconfig BOARD="${board}"
	emake dts BOARD="${board}"

	if use unified_depthcharge; then
		emake depthcharge_unified VB_SOURCE="${VBOOT_REFERENCE_DESTDIR}" \
		          PD_SYNC=$(usev pd_sync) \
			  LIBPAYLOAD_DIR="${SYSROOT}/firmware/libpayload/"
		emake dev_unified VB_SOURCE="${VBOOT_REFERENCE_DESTDIR}" \
		          PD_SYNC=$(usev pd_sync) \
			  LIBPAYLOAD_DIR="${SYSROOT}/firmware/libpayload_gdb/"
	else
		emake depthcharge_ro_rw VB_SOURCE="${VBOOT_REFERENCE_DESTDIR}" \
		          PD_SYNC=$(usev pd_sync) \
			  LIBPAYLOAD_DIR="${SYSROOT}/firmware/libpayload/"
		emake dev_ro_rw VB_SOURCE="${VBOOT_REFERENCE_DESTDIR}" \
		          PD_SYNC=$(usev pd_sync) \
			  LIBPAYLOAD_DIR="${SYSROOT}/firmware/libpayload_gdb/"
	fi

	emake netboot_unified VB_SOURCE="${VBOOT_REFERENCE_DESTDIR}" \
	          PD_SYNC=$(usev pd_sync) \
		  LIBPAYLOAD_DIR="${SYSROOT}/firmware/libpayload_gdb/"
}

src_install() {
	local dstdir="/firmware"
	local board=$(get_current_board_with_variant)
	if [[ ! -d "board/${board}" ]]; then
		board=$(get_current_board_no_variant)
	fi

	insinto "${dstdir}"
	newins .config depthcharge.config

	pushd "build" >/dev/null || die "couldn't access build/ directory"

	insinto "${dstdir}/dts"
	doins "fmap.dts"

	local files_to_copy=(netboot.{bin,elf{,.map},payload})
	if use unified_depthcharge ; then
		files_to_copy+=({depthcharge,dev}.{elf{,.map},payload})
	else
		files_to_copy+=({depthcharge,dev}.{ro,rw}.{bin,elf{,.map}})
	fi

	insinto "${dstdir}/depthcharge"
	doins "${files_to_copy[@]}"

	popd >/dev/null
}
