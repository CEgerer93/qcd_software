#!/bin/bash
#
#################
# BUILD QMP
#################
source env.sh

pushd ${SRCDIR}/qdpxx
autoreconf
popd

pushd ${BUILDDIR}

if [ -d ./build_qdp++-scalar_3d ]; 
then 
  rm -rf ./build_qdp++-scalar_3d
fi

mkdir  ./build_qdp++-scalar_3d
cd ./build_qdp++-scalar_3d


${SRCDIR}/qdpxx/configure \
        --enable-Nd=3 \
	--prefix=${INSTALLDIR}/qdp++-scalar_3d \
	--with-libxml2=${INSTALLDIR}/libxml2 \
	--enable-sse2 --enable-sse3 \
        --enable-parallel-arch=scalar \
	--enable-db-lite \
	--enable-precision=single \
	--enable-largefile \
	--enable-parallel-io \
        --enable-dml-output-buffering \
	CXXFLAGS="${PK_CXXFLAGS}" \
	CFLAGS="${PK_CFLAGS}" \
	CXX="${PK_CXX}" \
	CC="${PK_CC}" \
	--host=x86_64-linux-gnu --build=none \
	${OMPENABLE}

${MAKE}
${MAKE} install

popd
