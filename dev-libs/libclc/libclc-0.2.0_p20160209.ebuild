# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} )

EGIT_REPO_URI="http://llvm.org/git/${PN}.git"
EGIT_COMMIT="b518692b52a0bbdf9cf0e2167b9629dd9501abcd"

#if [[ ${PV} = 9999* ]]; then
	GIT_ECLASS="git-r3"
	EXPERIMENTAL="true"
#fi

inherit base python-any-r1 $GIT_ECLASS

DESCRIPTION="OpenCL C library"
HOMEPAGE="http://libclc.llvm.org/"

#if [[ $PV = 9999* ]]; then
	SRC_URI="${SRC_PATCHES}"
#else
#	SRC_URI="mirror://gentoo/${P}.tar.xz ${SRC_PATCHES}"
#fi

LICENSE="|| ( MIT BSD )"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=sys-devel/llvm-3.7"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}"

src_unpack() {
#	if [[ $PV = 9999* ]]; then
		git-r3_src_unpack
#	else
#		default
#		mv ${PN}-*/ ${P} || die
#	fi
}

src_configure() {
	./configure.py \
			--with-llvm-config="${EPREFIX}/usr/bin/llvm-config" \
			--prefix="${EPREFIX}/usr" \
			--with-cxx-compiler="$(tc-getCXX)"
}

src_compile() {
	default
	emake VERBOSE=1
}
