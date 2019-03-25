# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 cmake-utils

DESCRIPTION="Cross-platform C++ file system library supporting multiple backends"
HOMEPAGE="https://github.com/cginternals/cppfs"
#SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples ssh static-libs tests"

RDEPEND="
	examples? ( dev-cpp/cppassist:* )
	ssh? ( net-libs/libssh2 dev-libs/openssl:* sys-libs/zlib:* )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-3.0
	doc? ( >=app-doc/doxygen-1.8:* )"

EGIT_REPO_URI="https://github.com/cginternals/cppfs.git"
EGIT_BRANCH="master"
EGIT_COMMIT="v1.2.0"
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
		-DBUILD_SHARED_LIBS=$(usex static-libs OFF ON)
		-DOPTION_BUILD_DOCS=$(usex doc)
		-DOPTION_BUILD_EXAMPLES=$(usex examples)
		-DOPTION_BUILD_SSH_BACKEND=$(usex ssh)
		-DOPTION_BUILD_TESTS=$(usex tests)
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
