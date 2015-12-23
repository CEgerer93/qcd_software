#!/bin/bash
#
#################
# BUILD QMP
#################
source env.sh

pushd ${SRCDIR}/qdpxx
autoreconf -i -f 
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
	--with-libxml2=${INSTALLDIR}/libxml2 \
	--with-qmp=${INSTALLDIR}/qmp \
        --enable-parallel-arch=parscalar \
	--enable-db-lite \
	--enable-precision=single \
	--enable-largefile \
	--enable-parallel-io \
        --enable-sse2 \
        --enable-dml-output-buffering \
	CXXFLAGS="${PK_CXXFLAGS} -finline-limit=50000 -funroll-all-loops -fpeel-loops" \
	CFLAGS="${PK_CFLAGS} -pedantic -fargument-noalias-global -funroll-all-loops -fpeel-loops" \
	CXX="${PK_CXX}" \
	CC="${PK_CC}" \
	--host=x86_64-linux-gnu --build=none \
	${OMPENABLE}

${MAKE}
${MAKE} install

popd
