# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 cmake-utils

DESCRIPTION="Cross-platform C++ library providing localization tools"
HOMEPAGE="https://github.com/cginternals/cpplocate"
#SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs tests"

RDEPEND="
	tests? ( >=dev-cpp/gtest-1.8.0:* )"
DEPEND="${RDEPEND}"

EGIT_REPO_URI="https://github.com/cginternals/cpplocate.git"
EGIT_BRANCH="master"
# not set so that smart-live-rebuild recognize this package as a live one
#EGIT_COMMIT="HEAD"
EGIT_SUBMODULES=( '*' )

#CONFIG_CHECK=""

CMAKE_MAKEFILE_GENERATOR="emake"

src_prepare() {
	# user patches:
	epatch "${FILESDIR}/0_version-9999.patch"
	epatch "${FILESDIR}/1_ext_gtest_gmock.patch"

	# already includes epatch_user:
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

# fix multilib-strict QA failures
	mv "${ED%/}"/usr/{lib,$(get_libdir)} || die
}

#pkg_postinst() {
#}
