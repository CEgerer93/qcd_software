#!/bin/bash
#
#################
# BUILD Tensor
#################
source env.sh

pushd ${SRCDIR}/tensor
autoreconf -f -i 
popd

pushd ${BUILDDIR}

if [ -d ./build_tensor ]; 
then 
  rm -rf ./build_tensor
fi

mkdir  ./build_tensor
cd ./build_tensor


${SRCDIR}/tensor/configure --prefix=${INSTALLDIR}/tensor \
     --without-arpack \
     --with-libsci \
     F77="ftn" \
     ${OMPENABLE} \
     CC="${PK_CC}"  CXX="${PK_CXX}" 

${MAKE}
${MAKE} install

popd
#     CXXFLAGS=" " \
#     LDFLAGS="-L ${INSTALLDIR}/atlas/lib"  \
#     LIBS="-lm -llapack -lcblas -latlas"
