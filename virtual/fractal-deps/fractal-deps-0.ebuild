# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Virtual my fractal projects dependencies (for development)"

SLOT="0"
KEYWORDS="~amd64"
IUSE="doc qt5"

RDEPEND="
	>=media-libs/glm-0.9.8:*
	media-libs/glbinding:*
	media-libs/globjects:*
	qt5? ( >=dev-qt/qtcore-5.9:5 >=dev-qt/qtgui-5.9:5 >=dev-qt/qtwidgets-5.9:5 >=dev-qt/qtopengl-5.9:5
			media-libs/gloperate:*[qt5] )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-3.9:*
	doc? ( >=app-doc/doxygen-1.8:* )"
