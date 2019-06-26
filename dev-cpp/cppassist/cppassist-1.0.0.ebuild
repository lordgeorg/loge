# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake-utils

DESCRIPTION="Small but powerful and frequently required, stand alone C++ features"
HOMEPAGE="https://cppassist.org/"
#SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="boost doc examples minimal static-libs tests"
REQUIRED_USE="minimal? ( !doc !examples !tests )"

RDEPEND="boost? ( dev-libs/boost:* )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-3.0
	doc? ( >=app-doc/doxygen-1.8:*[dot]
		app-text/texlive-core:* )"

EGIT_REPO_URI="https://github.com/cginternals/cppassist.git"
EGIT_BRANCH="master"
EGIT_COMMIT="v1.0.0"
EGIT_SUBMODULES=( '*' )

#CONFIG_CHECK=""

CMAKE_MAKEFILE_GENERATOR="emake"

PATCHES=("${FILESDIR}/1_lib-${ARCH}.patch"
	"${FILESDIR}/2_docs-path.patch"
)

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(usex tests "-DCMAKE_CXX_FLAGS:STRING=-Wno-error=deprecated-copy" "")

		-DOPTION_BUILD_EXAMPLES=$(usex examples)
		-DOPTION_BUILD_DOCS=$(usex doc)
		-DOPTION_BUILD_TESTS=$(usex tests)
		-DOPTION_BUILD_WITH_STD_REGEX=$(usex boost OFF ON)
		-DBUILD_SHARED_LIBS=$(usex static-libs OFF ON)

#deactivating optional find_package calls
		-DCMAKE_DISABLE_FIND_PACKAGE_cppcheck=TRUE
		-DCMAKE_DISABLE_FIND_PACKAGE_clang_tidy=TRUE
		$(usex tests "-DCMAKE_DISABLE_FIND_PACKAGE_Threads=TRUE" "")
		$(usex tests "-DCMAKE_DISABLE_FIND_PACKAGE_PythonInterp=TRUE" "")
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
