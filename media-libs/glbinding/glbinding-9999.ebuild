# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 cmake-utils

DESCRIPTION="A C++ binding for the OpenGL API, generated using the gl.xml specification"
HOMEPAGE="https://github.com/cginternals/glbinding"
#SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples doc static-libs test boost"

#TODO cpplocate
RDEPEND="
	>=media-libs/glew-1.6:*
	examples? ( dev-cpp/cpplocate:* >=media-libs/glfw-3.2:* )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-3.0
	doc? ( >=app-doc/doxygen-1.8:* )"

EGIT_REPO_URI="https://github.com/cginternals/glbinding.git"
EGIT_BRANCH="master"
# not set so that smart-live-rebuild recognizes this package as a live one
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
		# currently no good use switch for this ... maybe minimal?
		-DOPTION_BUILD_TOOLS=ON
		-DOPTION_BUILD_EXAMPLES=$(usex examples)
		-DOPTION_BUILD_DOCS=$(usex doc)
		-DOPTION_BUILD_TESTS=$(usex test)
		-DOPTION_BUILD_GPU_TESTS=$(usex test)
		-DOPTION_BUILD_WITH_BOOST_THREADS=$(usex boost)
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
