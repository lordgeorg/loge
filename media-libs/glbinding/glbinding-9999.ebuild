# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake-utils

DESCRIPTION="A C++ binding for the OpenGL API, generated using the gl.xml specification"
HOMEPAGE="https://glbinding.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="boost cppcheck doc examples external-khr glew glfw minimal qt5 static-libs tests tools"
REQUIRED_USE="glfw? ( || ( tools examples ) )
	glew? ( examples )
	minimal? ( !cppcheck !doc !examples !tests !tools )
	qt5? ( examples )"

RDEPEND="boost? ( dev-libs/boost:* )
	examples? ( dev-cpp/cpplocate:*
		media-libs/mesa:* )
	!external-khr? ( !!media-libs/mesa:* )
	external-khr? ( media-libs/mesa:* )
	glew? ( >=media-libs/glew-1.6:* )
	glfw? ( >=media-libs/glfw-3.2:* )
	qt5? ( >=dev-qt/qtcore-5.1:5
		>=dev-qt/qtgui-5.1:5
		>=dev-qt/qtwidgets-5.1:5 )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-3.0
	doc? ( >=app-doc/doxygen-1.8:*[dot] )
	cppcheck? ( dev-util/cppcheck:* )"

EGIT_REPO_URI="https://github.com/cginternals/glbinding.git"
EGIT_BRANCH="master"
# not set so that smart-live-rebuild recognizes this package as a live one
#EGIT_COMMIT="HEAD"
EGIT_SUBMODULES=( '*' )

#CONFIG_CHECK=""

CMAKE_MAKEFILE_GENERATOR="emake"

PATCHES=("${FILESDIR}/0_version-9999.patch"
	"${FILESDIR}/1_lib-${ARCH}.patch"
	"${FILESDIR}/2_docs-path.patch"
)

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
#TODO remove when possible
		$(usex tests "-DCMAKE_CXX_FLAGS:STRING=-Wno-error=deprecated-copy" "")

		-DOPTION_BUILD_CHECK=$(usex cppcheck)
		-DOPTION_BUILD_TOOLS=$(usex tools)
		-DOPTION_BUILD_EXAMPLES=$(usex examples)
		-DOPTION_BUILD_DOCS=$(usex doc)
		-DOPTION_BUILD_TESTS=$(usex tests)
		-DOPTION_BUILD_WITH_BOOST_THREAD=$(usex boost)
		-DBUILD_SHARED_LIBS=$(usex static-libs OFF ON)

#deactivating optional find_package calls
		$(usex cppcheck "-DCMAKE_DISABLE_FIND_PACKAGE_clang_tidy=TRUE" "")
		$(usex examples $(usex glew "" "-DCMAKE_DISABLE_FIND_PACKAGE_GLEW=TRUE") "")
		$(usex examples $(usex glfw "" "-DCMAKE_DISABLE_FIND_PACKAGE_glfw3=TRUE") "")
		$(usex examples $(usex qt5 "" "-DCMAKE_DISABLE_FIND_PACKAGE_Qt5Core=TRUE") "")
		$(usex examples $(usex qt5 "" "-DCMAKE_DISABLE_FIND_PACKAGE_Qt5Gui=TRUE") "")
		$(usex examples $(usex qt5 "" "-DCMAKE_DISABLE_FIND_PACKAGE_Qt5Widgets=TRUE") "")
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
