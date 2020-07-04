#-----------------------------------------------------------------------------
# HDF4 Config file for compiling against hdf4 build directory
#-----------------------------------------------------------------------------
GET_FILENAME_COMPONENT (SELF_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)

#-----------------------------------------------------------------------------
# User Options
#-----------------------------------------------------------------------------
set (HDF4_ENABLE_PARALLEL OFF)
set (HDF4_BUILD_FORTRAN   OFF)
set (HDF4_BUILD_XDR_LIB   ON)
set (HDF4_BUILD_TOOLS     OFF)
set (HDF4_BUILD_UTILS     OFF)
set (HDF4_ENABLE_JPEG_LIB_SUPPORT ON)
set (HDF4_ENABLE_Z_LIB_SUPPORT ON)
set (HDF4_ENABLE_SZIP_SUPPORT  OFF)
set (HDF4_ENABLE_SZIP_ENCODING )
set (HDF4_BUILD_SHARED_LIBS    ON)

#-----------------------------------------------------------------------------
# Directories
#-----------------------------------------------------------------------------
set (HDF4_INCLUDE_DIR "D:/Development/op3d_active/hdf-4.2.11/hdf;D:/Development/op3d_active/hdf-4.2.11/mfhdf;D:/Development/op3d_active/hdf-4.2.11/mfhdf/xdr;D:/Development/op3d_active/hdf-4.2.11/msvc")

if (HDF4_BUILD_FORTRAN)
  set (HDF4_INCLUDE_DIR_FORTRAN "D:/Development/op3d_active/hdf-4.2.11/msvc/bin/fortran" )
endif (HDF4_BUILD_FORTRAN)
  
if (HDF4_BUILD_XDR_LIB)
  set (HDF4_INCLUDE_DIR_XDR ${HDF4_INCLUDE_DIR} )
endif (HDF4_BUILD_XDR_LIB)

if (HDF4_BUILD_TOOLS)
  set (HDF4_INCLUDE_DIR_TOOLS ${HDF4_INCLUDE_DIR} )
endif (HDF4_BUILD_TOOLS)

if (HDF4_BUILD_UTILS)
  set (HDF4_INCLUDE_DIR_UTILS ${HDF4_INCLUDE_DIR} )
endif (HDF4_BUILD_UTILS)

if (HDF4_BUILD_SHARED_LIBS)
  set (H4_BUILT_AS_DYNAMIC_LIB 1 )
else (HDF4_BUILD_SHARED_LIBS)
  set (H4_BUILT_AS_STATIC_LIB 1 )
endif (HDF4_BUILD_SHARED_LIBS)

#-----------------------------------------------------------------------------
# Version Strings
#-----------------------------------------------------------------------------
set (HDF4_VERSION_STRING 4.2.11)
set (HDF4_VERSION_MAJOR  4.2)
set (HDF4_VERSION_MINOR  11)

#-----------------------------------------------------------------------------
# Don't include targets if this file is being picked up by another
# project which has already build hdf4 as a subproject
#-----------------------------------------------------------------------------
if (NOT TARGET "hdf4")
  include (${SELF_DIR}/hdf4-targets.cmake)
  set (HDF4_LIBRARIES "xdr;hdf;mfhdf")
endif (NOT TARGET "hdf4")
