# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake-utils

DESCRIPTION="Small but powerful and frequently required, stand alone C++ features"
HOMEPAGE="https://github.com/cginternals/cppassist"
#SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples static-libs tests"

RDEPEND="
	tests? ( dev-lang/python:* )"
DEPEND="${RDEPEND}"

EGIT_REPO_URI="https://github.com/cginternals/cppassist.git"
EGIT_BRANCH="master"
EGIT_COMMIT="v1.0.0"
EGIT_SUBMODULES=( '*' )

#CONFIG_CHECK=""

CMAKE_MAKEFILE_GENERATOR="emake"

src_prepare() {
	# user patches:

	# already includes epatch_user:
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DOPTION_BUILD_EXAMPLES=$(usex examples)
		-DOPTION_BUILD_DOCS=$(usex doc)
		-DOPTION_BUILD_TESTS=$(usex tests)
		-DOPTION_BUILD_WITH_STD_REGEX=ON
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
