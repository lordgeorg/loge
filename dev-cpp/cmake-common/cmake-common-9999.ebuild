# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 cmake-utils

DESCRIPTION="Tool for creating cmake-based projects"
HOMEPAGE="https://github.com/lordgeorg/cmake-common"
#SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug static-libs"

DEPEND=">=dev-util/cmake-3.9"
RDEPEND="${DEPEND}"

EGIT_REPO_URI="https://github.com/lordgeorg/cmake-common.git"
EGIT_BRANCH="master"
EGIT_COMMIT="HEAD"
EGIT_SUBMODULES=( '*' )

#CONFIG_CHECK=""

src_prepare() {
	default
}

src_compile() {
	default
}

src_install() {
	default
}

pkg_postinst() {
	elog
	elog "!!!!!!!1bla!!!!!!!!!"
}

