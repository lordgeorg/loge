# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake-utils

DESCRIPTION="C++ library that converts Qt supported images to OpenGL raw format"
HOMEPAGE="https://github.com/cginternals/glraw"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs tests"
REQUIRED_USE=""

RDEPEND=">=dev-qt/qtcore-5.1:5
	>=dev-qt/qtgui-5.1:5
	>=dev-qt/qtwidgets-5.1:5
	>=dev-qt/qtopengl-5.1:5"
DEPEND="${RDEPEND}
	>=dev-util/cmake-3.0:*
	doc? ( >=app-doc/doxygen-1.8:* )"

EGIT_REPO_URI="https://github.com/cginternals/glraw.git"
EGIT_BRANCH="master"
# not set so that smart-live-rebuild recognize this package as a live one
#EGIT_COMMIT="HEAD"
EGIT_SUBMODULES=( '*' )

CMAKE_MAKEFILE_GENERATOR="emake"

PATCHES=("${FILESDIR}/${PV}/0_version-9999.patch"
	"${FILESDIR}/${PV}/1_lib-${ARCH}.patch"
	"${FILESDIR}/${PV}/2_docs-path.patch"
)

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DOPTION_BUILD_DOCS=$(usex doc)
		-DOPTION_BUILD_TESTS=$(usex tests)
		-DBUILD_SHARED_LIBS=$(usex static-libs OFF ON)
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
}
