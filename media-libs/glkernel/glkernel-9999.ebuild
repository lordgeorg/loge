# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake-utils

DESCRIPTION="C++ library for pre-computing noise, and random sample-kernels"
HOMEPAGE="https://github.com/cginternals/glkernel"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="benchmarks doc examples minimal qt5 tests tools static-libs"
REQUIRED_USE="minimal? ( !benchmarks !doc !examples !tests !tools )
	qt5? ( examples )"

RDEPEND="
	>=media-libs/glm-0.9.6:*
	qt5? ( >=dev-qt/qtcore-5.1:5
		>=dev-qt/qtgui-5.1:5
		>=dev-qt/qtwidgets-5.1:5
		>=dev-qt/qtopengl-5.1:5 )
	tools? ( dev-cpp/cppassist:*
		dev-cpp/cpplocate:*
		dev-cpp/cppfs:*
		media-libs/libpng:* )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-3.0:*
	doc? ( >=app-doc/doxygen-1.8:*[dot]
		app-text/texlive-core:* )"

EGIT_REPO_URI="https://github.com/cginternals/glkernel.git"
EGIT_BRANCH="master"
#EGIT_COMMIT="HEAD"
EGIT_SUBMODULES=( '*' )

CMAKE_MAKEFILE_GENERATOR="emake"

PATCHES=("${FILESDIR}/0_version-9999.patch"
	"${FILESDIR}/2_docs-path.patch"
	"${FILESDIR}/3_find-glm.patch"
)

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_CXX_FLAGS:STRING=-fopenmp

		-DOPTION_BUILD_BENCHMARKS=$(usex benchmarks)
		-DOPTION_BUILD_DOCS=$(usex doc)
		-DOPTION_BUILD_EXAMPLES=$(usex examples)
		-DOPTION_BUILD_TESTS=$(usex tests)
		-DOPTION_BUILD_TOOLS=$(usex tools)
		-DBUILD_SHARED_LIBS=$(usex static-libs OFF ON)

#deactivating optional find_package calls
		-DCMAKE_DISABLE_FIND_PACKAGE_cppcheck=TRUE
		-DCMAKE_DISABLE_FIND_PACKAGE_clang_tidy=TRUE

		$(usex benchmarks -DCMAKE_DISABLE_FIND_PACKAGE_Git=TRUE)

		$(usex examples -DCMAKE_DISABLE_FIND_PACKAGE_Qt5Core=$(usex qt5 FALSE TRUE))
		$(usex examples -DCMAKE_DISABLE_FIND_PACKAGE_Qt5Gui=$(usex qt5 FALSE TRUE))
		$(usex examples -DCMAKE_DISABLE_FIND_PACKAGE_Qt5Widgets=$(usex qt5 FALSE TRUE))
		$(usex examples -DCMAKE_DISABLE_FIND_PACKAGE_Qt5OpenGL=$(usex qt5 FALSE TRUE))

		$(usex tests -DCMAKE_DISABLE_FIND_PACKAGE_PythonInterp=TRUE)
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
