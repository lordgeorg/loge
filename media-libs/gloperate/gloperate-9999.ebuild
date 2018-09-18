# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 cmake-utils

DESCRIPTION="C++ library for defining and controlling GPU rendering/processing operations"
HOMEPAGE="https://github.com/cginternals/gloperate"
#SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples doc glfw qt5 ffmpeg static-libs hidapi"

RDEPEND="
	dev-cpp/cppexpose:*
	dev-cpp/cppassist:*
	dev-cpp/cpplocate:*
	media-libs/glkernel:*
	>=media-libs/glbinding-1.0.0:*
	>=media-libs/glm-0.9.4:*
	>=media-libs/globjects-0.3.2:*
	media-libs/qmltoolbox:*
	glfw? ( >=media-libs/glfw-3.1:* )
	qt5? ( >=dev-qt/qtcore-5.1:5 >=dev-qt/qtgui-5.1:5 >=dev-qt/qtwidgets-5.1:5 >=dev-qt/qtopengl-5.1:5 )
	ffmpeg? ( media-video/ffmpeg:* )
	hidapi? ( dev-libs/hidapi:* )
	examples? ( media-libs/glkernel:* )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-3.0:*
	doc? ( >=app-doc/doxygen-1.8:* )"

EGIT_REPO_URI="https://github.com/cginternals/gloperate.git"
EGIT_BRANCH="master"
# not set so that smart-live-rebuild recognize this package as a live one
#EGIT_COMMIT="HEAD"
EGIT_SUBMODULES=( '*' )

#CONFIG_CHECK=""

CMAKE_MAKEFILE_GENERATOR="emake"

src_prepare() {
	# user patches:
	epatch "${FILESDIR}/${PV}/version-9999.patch"

	# already includes epatch_user:
	cmake-utils_src_prepare
}

src_configure() {
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_test() {
	cmake-utils_src_test
}

src_install() {
	cmake-utils_src_install

# fix multilib-strict QA failures
	mv "${ED%/}"/usr/{lib,$(get_libdir)} || die
}

#pkg_postinst() {
#}
