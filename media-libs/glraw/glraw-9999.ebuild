# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 cmake-utils

DESCRIPTION="C++ library that converts Qt supported images to OpenGL raw format"
HOMEPAGE="https://github.com/cginternals/glraw"
#SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs tests"

RDEPEND="
	>=dev-qt/qtcore-5.1:5 >=dev-qt/qtgui-5.1:5 >=dev-qt/qtwidgets-5.1:5 >=dev-qt/qtopengl-5.1:5"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.8.9:*
	doc? ( >=app-doc/doxygen-1.8:* )"

EGIT_REPO_URI="https://github.com/cginternals/glraw.git"
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
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=$(usex static-libs OFF ON)
		-DOPTION_BUILD_DOCS=$(usex doc)
		-DOPTION_BUILD_TESTS=$(usex tests)
	)

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
