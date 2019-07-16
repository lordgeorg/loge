# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake-utils

DESCRIPTION="QML item library for cross-platform graphics applications"
HOMEPAGE="https://github.com/cginternals/qmltoolbox"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples static-libs tests"
REQUIRED_USE=""

RDEPEND="dev-cpp/cpplocate:*
	>media-libs/glm-0.9:*
	>=dev-qt/qtcore-5.4:5
	>=dev-qt/qtdeclarative-5.4:5
	examples? ( >=dev-qt/qtgui-5.4:5 >=dev-qt/qtwidgets-5.4:5 )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-3.0:*"

EGIT_REPO_URI="https://github.com/cginternals/qmltoolbox.git"
EGIT_BRANCH="master"
EGIT_COMMIT="8ddfb4dce1bb5cb1522910ba556ac5133cfb7485"
EGIT_SUBMODULES=( '*' )

CMAKE_MAKEFILE_GENERATOR="emake"

PATCHES=("${FILESDIR}/1_lib-${ARCH}.patch"
)

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DOPTION_BUILD_EXAMPLES=$(usex examples)
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
