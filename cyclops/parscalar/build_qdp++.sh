#!/bin/bash
#
#################
# BUILD QMP
#################
source env.sh

pushd ${SRCDIR}/qdpxx
./autogen.sh
popd

pushd ${BUILDDIR}

if [ -d ./build_qdp++ ]; 
then 
  rm -rf ./build_qdp++
fi

mkdir  ./build_qdp++
cd ./build_qdp++


${SRCDIR}/qdpxx/configure \
	--prefix=${INSTALLDIR}/qdp++ \
	--with-qmp=${INSTALLDIR}/qmp \
	--with-libxml2=${INSTALLDIR}/libxml2 \
        --enable-parallel-arch=parscalar \
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
