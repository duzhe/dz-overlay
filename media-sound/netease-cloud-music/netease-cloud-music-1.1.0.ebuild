# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils gnome2-utils unpacker pax-utils xdg-utils

DESCRIPTION="Netease cloud music player"
HOMEPAGE="http://music.163.com/"
SRC_URI="http://d1.music.126.net/dmusic/${PN}_${PV}_amd64_ubuntu.deb"

LICENSE="None"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""
RESTRICT="bindist mirror strip"

DEPEND=""
RDEPEND="
	gnome-base/gconf:2
	>=dev-libs/atk-1.12.4
	>=x11-libs/cairo-1.2.4
	>=net-print/cups-1.3.0
	>=sys-apps/dbus-1.8.1
	>=dev-libs/expat-2.0.1
	>=media-libs/fontconfig-2.10.0
	>=gnome-base/gconf-3.2.5
	>=x11-libs/gdk-pixbuf-2.22.0
	>=dev-libs/glib-2.31.8
	x11-libs/gtk+:2
	>=dev-libs/nspr-4.9.2
	>=dev-libs/nss-3.13.4
	>=x11-libs/pango-1.14.0
	>=dev-db/sqlite-3.5.9
	>=media-libs/taglib-1.9.1
	>=media-video/vlc-2.1.0
	>=x11-libs/libX11-1.4.99
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	>=sys-libs/zlib-1.1.4
"

QA_PREBUILT="*"
QA_DESKTOP_FILE="usr/share/applications/netease-cloud-music.desktop"
S=${WORKDIR}

pkg_pretend() {
	use amd64 || die "only works on amd64"
}

src_unpack() {
	:
}

src_install() {
	dodir /
	cd "${ED}" || die
	unpacker

	local size
	for size in 16 22 24 32 48 64 128 256 ; do
		newicon -s ${size} "usr/share/icons/hicolor/scalable/apps/netease-cloud-music.svg" ${PN}.png
	done

	pax-mark m "usr/bin/netease-cloud-music"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}
