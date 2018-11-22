# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 cmake-utils

DESCRIPTION="API specification and reference implementations for glyph rendering in 2D and 3D"
HOMEPAGE="https://github.com/cginternals/openll-cpp"
#SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples static-libs tests"

#TODO cpplocate
RDEPEND="
	examples? ( >=media-libs/glfw-3.2:* )
	>media-libs/glm-0.9.8:*
	dev-cpp/cppassist:*
	dev-cpp/cppfs:*
	dev-cpp/cpplocate:*
	media-libs/glbinding:*
	media-libs/globjects:*"
DEPEND="${RDEPEND}
	>=dev-util/cmake-3.0"

EGIT_REPO_URI="https://github.com/cginternals/openll-cpp.git"
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

# fix multilib-strict QA failures
	mv "${ED%/}"/usr/{lib,$(get_libdir)} || die
}

#pkg_postinst() {
#}
