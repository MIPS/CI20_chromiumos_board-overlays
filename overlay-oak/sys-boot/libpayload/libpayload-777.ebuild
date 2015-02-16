# Copyright 2015 The Chromium OS Authors.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

EGIT_REPO_URI="https://github.com/mtk09422/chromiumos-third_party-coreboot.git"
EGIT_BRANCH="tot-oak"
EGIT_COMMIT="tot-oak"

DESCRIPTION="coreboot's libpayload library"
HOMEPAGE="http://www.coreboot.org"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* arm"
IUSE=""

RDEPEND=""
DEPEND=""


# Don't strip to ease remote GDB use (cbfstool strips final binaries anyway)
STRIP_MASK="*"
CROS_WORKON_BLACKLIST="1"

inherit cros-workon cros-board toolchain-funcs git-2

src_unpack() {
	git-2_src_unpack
}

src_compile() {
	tc-getCC
	local board=$(get_current_board_with_variant)

	# Firmware related binaries are compiled with a 32-bit toolchain
	# on 64-bit platforms
	if use amd64 ; then
		export CROSS_COMPILE="i686-pc-linux-gnu-"
		export CC="${CROSS_COMPILE}gcc"
	else
		export CROSS_COMPILE=${CHOST}-
	fi

	local extra_flags="-ffunction-sections"
	if use x86 || use amd64 ; then
		extra_flags+=" -mpreferred-stack-boundary=2"
	elif use arm || use arm64 ; then
		# Export the known cross compilers for ARM systems. Include
		# both v7a and 64-bit armv8 compilers so there isn't a reliance
		# on what the default profile is for exporting a compiler. The
		# reasoning is that the firmware may need both to build and
		# and boot.
		export CROSS_COMPILE_arm64="aarch64-cros-linux-gnu-"
		export CROSS_COMPILE_arm="armv7a-cros-linux-gnu-"
	fi

	local libpayloaddir="payloads/libpayload"
	if [[ ! -s "${libpayloaddir}/configs/config.${board}" ]]; then
		board=$(get_current_board_no_variant)
	fi

	local board_config="$(realpath "${libpayloaddir}/configs/config.${board}")"

	[ -f "${board_config}" ] || die "${board_config} does not exist"

	# get into the source directory
	pushd "${libpayloaddir}"

	# nuke build artifacts potentially present in the source directory
	emake distclean
	cp "${board_config}" .config
	emake oldconfig
	emake obj="build" EXTRA_CFLAGS="${extra_flags}"
	cp .config build

	# Build a second set of libraries with GDB support for developers
	cp "${board_config}" .config
	sed -i "s/# CONFIG_LP_REMOTEGDB is not set/CONFIG_LP_REMOTEGDB=y/" .config
	emake oldconfig
	emake obj="build_gdb" EXTRA_CFLAGS="${extra_flags}"
	cp .config build_gdb

	popd
}

install_libpayload() {
	local suffix="$1"
	local src_root="payloads/libpayload/"
	local build_root="${src_root}/build${suffix}"
	local destdir="/firmware/libpayload${suffix}"

	local archdir=""

	if [[ -n "${CHROMEOS_LIBPAYLOAD_ARCH_DIR}" ]] ; then
		archdir="${CHROMEOS_LIBPAYLOAD_ARCH_DIR}"
	else
		case ${ARCH} in
		amd64) archdir="x86";;
		*) archdir=${ARCH};;
		esac
	fi

	insinto "${destdir}"/lib
	doins "${build_root}"/libpayload.a
	if [ -f "${src_root}"/lib/libpayload.ldscript ]; then
		doins "${src_root}"/lib/libpayload.ldscript
	fi
	if [ -f "${src_root}"/arch/${archdir}/libpayload.ldscript ]; then
		doins "${src_root}"/arch/${archdir}/libpayload.ldscript
	fi

	insinto "${destdir}"/lib/"${archdir}"
	doins "${build_root}"/head.o

	insinto "${destdir}"/include
	doins "${build_root}"/libpayload-config.h
	for file in `cd ${src_root} && find include -name *.h -type f`; do \
		insinto "${destdir}"/`dirname ${file}`; \
		doins "${src_root}"/"${file}"; \
	done

	exeinto "${destdir}"/bin
	insinto "${destdir}"/bin
	doexe "${src_root}"/bin/lpgcc
	doexe "${src_root}"/bin/lpas
	doins "${src_root}"/bin/lp.functions

	insinto "${destdir}"
	newins "${src_root}"/.xcompile libpayload.xcompile
	newins "${build_root}"/.config libpayload.config
}

src_install() {
	install_libpayload ""
	install_libpayload "_gdb"
}
