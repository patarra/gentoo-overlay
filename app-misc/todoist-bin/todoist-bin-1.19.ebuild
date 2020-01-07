# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils desktop

EXEC_NAME=todoist
DESCRIPTION="Electron wrapper for todoist web client."
HOMEPAGE="https://github.com/KryDos/todoist-linux"
SRC_URI="https://github.com/KryDos/todoist-linux/releases/download/${PV}/todoist-linux.zip"
RESTRICT="mirror strip bindist"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""

QA_PRESTRIPPED="opt/${PN}/todoist"
QA_PREBUILT="opt/${PN}/todoist"
S="${WORKDIR}/dist/linux-unpacked"

src_install() {
	dodir "/opt"
   	# Using doins -r would strip executable bits from all binaries
	cp -pPR "${S}" "${D}/opt/${PN}" || die "Failed to copy files"
	dosym "${EPREFIX}/opt/${PN}/bin/todoist" "/usr/bin/${EXEC_NAME}"
    local icon_size
	for icon_size in 16 32 48 64 128 256 512; do
		newicon -s "${icon_size}" \
			"${FILESDIR}/icon${icon_size}.png" \
			todoist.png
	done

	make_desktop_entry "${EXEC_NAME}" "Todoist" "todoist" "Office" 

}
