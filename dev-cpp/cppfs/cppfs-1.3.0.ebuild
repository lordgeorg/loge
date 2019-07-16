# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake-utils

DESCRIPTION="Cross-platform C++ file system library supporting multiple backends"
HOMEPAGE="https://github.com/cginternals/cppfs"
#SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples minimal ssh static-libs tests"
REQUIRED_USE="minimal? ( !doc !examples !ssh !tests )"

RDEPEND="examples? ( dev-cpp/cppassist:* )
	ssh? ( net-libs/libssh2
		dev-libs/openssl:*
		sys-libs/zlib:* )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-3.0
	doc? ( >=app-doc/doxygen-1.8:*[dot] )"

EGIT_REPO_URI="https://github.com/cginternals/cppfs.git"
EGIT_BRANCH="master"
EGIT_COMMIT="v1.3.0"
EGIT_SUBMODULES=( '*' )

#CONFIG_CHECK=""

CMAKE_MAKEFILE_GENERATOR="emake"

PATCHES=(
	"${FILESDIR}/1_lib-${ARCH}.patch"
	"${FILESDIR}/2_docs-path.patch"
)

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		#$(usex tests "-DCMAKE_CXX_FLAGS:STRING=-Wno-error=deprecated-copy" "")

		-DBUILD_SHARED_LIBS=$(usex static-libs OFF ON)
		-DOPTION_BUILD_DOCS=$(usex doc)
		-DOPTION_BUILD_EXAMPLES=$(usex examples)
		-DOPTION_BUILD_SSH_BACKEND=$(usex ssh)
		-DOPTION_BUILD_TESTS=$(usex tests)

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
