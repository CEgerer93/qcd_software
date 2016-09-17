. ../setup.sh

##### 
# SET UP ENVIRONMENT
#
# This should do the following:
#  setup mpicc and mpicxx on your PATH
#  setup nvcc on your PATH
#  setup LD_LIBRARY_PATH for CUDA and MPI 
#  set env var MPIHOME pointing to the MPI installation
#  set env var CUDA_INSTALL_PATH to point to CUDA Install location
#  
#  FOR LLNL at Livermore, and Keeneland this is done through modules
#  The modules below are for Keeneland. If you are not using modules
#  Please manually set the MPIHOME and CUDA_INSTALL_PATH variables
#  If your MPI wrapper is not mpicc/mpicxx you may still need to do some
#  tedious mucking about in the src/quda/make.inc file
#

MPICH_DIR=/opt/openmpi-1.10.2

export LD_LIBRARY_PATH=/opt/gcc-4.9.2/lib:/opt/gcc-4.9.2/lib64:$MPICH_DIR/lib:$MPICH_DIR/lib/shared
export PATH=/opt/gcc-4.9.2/bin:$MPICH_DIR/bin:$PATH



### DIRECTORIES
MPIHOME=${MPICH_DIR}

# The directory containing the build scripts, this script and the src/ tree
TOPDIR=`pwd`

# Install directory
INSTALLDIR=/opt/scidac
SCALAR_INSTALLDIR=/opt/scidac

# Source directory
SRCDIR=${TOPDIR}/../src

# Build directory
BUILDDIR=${TOPDIR}/build

### ENV VARS for CUDA/MPI
# These are used by the configure script to make make.inc
PK_MPI_HOME=${MPIHOME}               # At LLNL Loading the module sets this. Otherwise do by hand

### OpenMP
OMPFLAGS="-fopenmp -DUSE_OMP"
OMPENABLE="--enable-openmp"
#OMPFLAGS=""
OMPENABLE=""

### COMPILER FLAGS
PK_CXXFLAGS=${OMPFLAGS}" -O3 -std=c++0x -march=native"
PK_CFLAGS=${OMPFLAGS}" -O3 -std=gnu99 -march=native"

### Make
MAKE="make -j 32"

### MPI
PK_CC=gcc
PK_CXX=g++
HOST_CC=gcc
HOST_CXX=g++
HOST_CXXFLAGS="-O3 -march=native"
HOST_CFLAGS="-03 -march=native"
