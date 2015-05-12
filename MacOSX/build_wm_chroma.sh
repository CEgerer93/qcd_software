#!/bin/bash
#
#################
# BUILD Chroma
#################
source env.sh


pushd ${BUILDDIR}

if [ -d ./build_wm_chroma-scalar ]; 
then 
  rm -rf ./build_wm_chroma-scalar
fi

mkdir  ./build_chroma-scalar
cd ./build_chroma-scalar
cp -p -r ${SRCDIR}/wm_chroma/* .

cat > Makefile<<EOF
CHROMA_DIR = /usr/local/scidac/chroma/scalar
ARPREC_DIR = /usr/local
QD_DIR = /usr/local
ITPP_DIR = /usr/local
include Make.inc
EOF

${MAKE}
INSTALL_DIR=/usr/local/scidac/wm_chroma/scalar 
if [ -d $INSTALL_DIR ]; 
then 
  rm -rf $INSTALL_DIR
fi
mkdir -p $INSTALL_DIR
cp wm_chroma $INSTALL_DIR

popd
