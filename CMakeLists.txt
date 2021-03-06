cmake_minimum_required (VERSION 2.8.11)
PROJECT (HDF4 C CXX)

#-----------------------------------------------------------------------------
# Instructions for use : Normal Build
#
# For standard build of HDF4 libraries,tests and tools. 
# Run cmake using the HDF4 source tree to generate a build tree.
# Enable/Disable options according to requirements and
# set CMAKE_INSTALL_PREFIX to the required install path.
# Make install can be used to install all components for system-wide use.
#
#-----------------------------------------------------------------------------
# Instructions for use : Sub-Project Build
#
# To include HDF4 as a sub-project within another project. 
# Set HDF4_EXTERNALLY_CONFIGURED to 1 in the parent project and
# supply values for the following variables...
#
# HDF4_EXPORTED_TARGETS :
#   Set this to the name of the targets variable which controls exports
#   If unset (because parent project does not support/use the
#   install (EXPORT target...) syntax), then targets are not configured
#   for export during install.
#
# HDF4_LIB_DEPENDENCIES :
#   If the build of HDF4 libs is being customized, then rules for the
#   dependencies of the HDF4 libs may be 'incomplete', add additional
#   dependencies to this variable so that external projects pick them up
#
# HDF4_EXTERNAL_LIB_PREFIX :
#   If the parent project needs to install hdf libraries, but avoid 
#   name conflicts with system versions, then a prefix may be added
#   to ensure that the correct versions configured are used.
#
# Consider this example, it builds its own zlib
# library and tells HDF4 to add it as a dependency - this ensures that
# any project making use of this build of HDF4 will use the correct zlib
#
#   # Tell hdf4 that we are manually overriding certain settings
#   set (HDF4_EXTERNALLY_CONFIGURED 1)
#   # Avoid duplicating names of installed libraries
#   set (HDF4_EXTERNAL_LIB_PREFIX "prj")
#   # Targets linking to the HDF4 libs need to know their names
#   # if they are changed in the sub project, they should be here too
#   set (HDF4_LIB_NAME "prjhdf4")
#   set (HDF4_MF_LIB_NAME "prjhdf4_mf")
#   set (HDF4_LIBRARY "${HDF4_LIB_NAME};${HDF4_MF_LIB_NAME}")
#   # Export configuration to this export variable
#   set (HDF4_EXPORTED_TARGETS "project-targets")
#
#   # Setup all necessary overrides for zlib so that HDF4 uses our
#   # internally compiled zlib rather than any other version
#   if (HDF4_ENABLE_Z_LIB_SUPPORT)
#    # We must tell the main HDF4 library that it depends on our zlib 
#     set (HDF4_LIB_DEPENDENCIES prjzlib)    
#     # Override the zlib header file
#     if (PRJ_USE_SYSTEM_ZLIB)
#       set (H4_ZLIB_HEADER "zlib.h")
#     else (PRJ_USE_SYSTEM_ZLIB)
#      set (H4_ZLIB_HEADER "prj_zlib.h")
#       # Set vars that FindZlib would have set if used in sub project
#       set (ZLIB_INCLUDE_DIRS "${PRJ_ZLIB_INCLUDE_DIRS}")
#       set (ZLIB_LIBRARIES prjzlib)
#     endif (PRJ_USE_SYSTEM_ZLIB)
#  endif (HDF4_ENABLE_Z_LIB_SUPPORT)
#   
#   # Add the sub project
#   add_subdirectory (Utilities/hdf4.2.5)
#   # Add the HDF4 dirs to our include path
#   set (HDF4_INCLUDE_DIR 
#       ${PROJECT_SOURCE_DIR}/Utilities/hdf4.2.5/hdf/src
#       ${PROJECT_BINARY_DIR}/Utilities/hdf4.2.5
#       ${PROJECT_SOURCE_DIR}/Utilities/hdf4.2.5/mfhdf/libsrc
#   )
#
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# Allow Visual Studio solution directories
#-----------------------------------------------------------------------------
# Provide a way for Visual Studio Express users to turn OFF the new FOLDER
# organization feature. Default to ON for non-Express users. Express users must
# explicitly turn off this option to build HDF5 in the Express IDE...
#
option (HDF4_USE_FOLDERS "Enable folder grouping of projects in IDEs." ON)
mark_as_advanced (HDF4_USE_FOLDERS)
if (HDF4_USE_FOLDERS)
  set_property (GLOBAL PROPERTY USE_FOLDERS ON)
endif (HDF4_USE_FOLDERS)
option (HDF4_NO_PACKAGES "CPACK - Disable packaging" OFF)
mark_as_advanced (HDF4_NO_PACKAGES)

#-----------------------------------------------------------------------------
# Set the core names of all the libraries
#-----------------------------------------------------------------------------
set (HDF4_LIB_CORENAME              "hdf4")
set (HDF4_SRC_LIB_CORENAME          "hdf")
set (HDF4_SRC_FCSTUB_LIB_CORENAME   "hdf_fcstub")
set (HDF4_SRC_FORTRAN_LIB_CORENAME  "hdf_fortran")
set (HDF4_MF_LIB_CORENAME           "mfhdf")
set (HDF4_MF_XDR_LIB_CORENAME       "xdr")
set (HDF4_HDF_TEST_LIB_CORENAME     "hdf_test")
set (HDF4_HDF_TEST_FCSTUB_LIB_CORENAME     "hdf_test_fcstub")
set (HDF4_MF_FCSTUB_LIB_CORENAME    "mfhdf_fcstub")
set (HDF4_MF_FORTRAN_LIB_CORENAME   "mfhdf_fortran")
set (HDF4_MF_TEST_LIB_CORENAME      "mf_test")
set (HDF4_TOOLS_LIB_CORENAME        "h4tools")

#-----------------------------------------------------------------------------
# Set the true names of all the libraries if customized by external project
#-----------------------------------------------------------------------------
set (HDF4_LIB_NAME              "${HDF4_EXTERNAL_LIB_PREFIX}${HDF4_LIB_CORENAME}")
set (HDF4_SRC_LIB_NAME          "${HDF4_EXTERNAL_LIB_PREFIX}${HDF4_SRC_LIB_CORENAME}")
set (HDF4_SRC_FCSTUB_LIB_NAME   "${HDF4_EXTERNAL_LIB_PREFIX}${HDF4_SRC_FCSTUB_LIB_CORENAME}")
set (HDF4_SRC_FORTRAN_LIB_NAME  "${HDF4_EXTERNAL_LIB_PREFIX}${HDF4_SRC_FORTRAN_LIB_CORENAME}")
set (HDF4_MF_LIB_NAME           "${HDF4_EXTERNAL_LIB_PREFIX}${HDF4_MF_LIB_CORENAME}")
set (HDF4_MF_XDR_LIB_NAME       "${HDF4_EXTERNAL_LIB_PREFIX}${HDF4_MF_XDR_LIB_CORENAME}")
set (HDF4_HDF_TEST_LIB_NAME     "${HDF4_EXTERNAL_LIB_PREFIX}${HDF4_HDF_TEST_LIB_CORENAME}")
set (HDF4_HDF_TEST_FCSTUB_LIB_NAME     "${HDF4_EXTERNAL_LIB_PREFIX}${HDF4_HDF_TEST_FCSTUB_LIB_CORENAME}")
set (HDF4_MF_FCSTUB_LIB_NAME    "${HDF4_EXTERNAL_LIB_PREFIX}${HDF4_MF_FCSTUB_LIB_CORENAME}")
set (HDF4_MF_FORTRAN_LIB_NAME   "${HDF4_EXTERNAL_LIB_PREFIX}${HDF4_MF_FORTRAN_LIB_CORENAME}")
set (HDF4_MF_TEST_LIB_NAME      "${HDF4_EXTERNAL_LIB_PREFIX}${HDF4_MF_TEST_LIB_CORENAME}")
set (HDF4_TOOLS_LIB_NAME        "${HDF4_EXTERNAL_LIB_PREFIX}${HDF4_TOOLS_LIB_CORENAME}")

#-----------------------------------------------------------------------------
# Set the target names of all the libraries
#-----------------------------------------------------------------------------
set (HDF4_LIB_TARGET              ${HDF4_LIB_CORENAME})
set (HDF4_SRC_LIB_TARGET          ${HDF4_SRC_LIB_CORENAME})
set (HDF4_SRC_FCSTUB_LIB_TARGET   ${HDF4_SRC_FCSTUB_LIB_CORENAME})
set (HDF4_SRC_FORTRAN_LIB_TARGET  ${HDF4_SRC_FORTRAN_LIB_CORENAME})
set (HDF4_MF_LIB_TARGET           ${HDF4_MF_LIB_CORENAME})
set (HDF4_MF_XDR_LIB_TARGET       ${HDF4_MF_XDR_LIB_CORENAME})
set (HDF4_HDF_TEST_LIB_TARGET     ${HDF4_HDF_TEST_LIB_CORENAME})
set (HDF4_HDF_TEST_FCSTUB_LIB_TARGET     ${HDF4_HDF_TEST_FCSTUB_LIB_CORENAME})
set (HDF4_MF_FCSTUB_LIB_TARGET    ${HDF4_MF_FCSTUB_LIB_CORENAME})
set (HDF4_MF_FORTRAN_LIB_TARGET   ${HDF4_MF_FORTRAN_LIB_CORENAME})
set (HDF4_MF_TEST_LIB_TARGET      ${HDF4_MF_TEST_LIB_CORENAME})
set (HDF4_TOOLS_LIB_TARGET        ${HDF4_TOOLS_LIB_CORENAME})

#-----------------------------------------------------------------------------
# Define some CMake variables for use later in the project
#-----------------------------------------------------------------------------
set (HDF_RESOURCES_DIR        ${HDF4_SOURCE_DIR}/config/cmake)
set (HDF_RESOURCES_EXT_DIR    ${HDF4_SOURCE_DIR}/config/cmake_ext_mod)
set (HDF4_HDFSOURCE_DIR       ${HDF4_SOURCE_DIR}/hdf/src)
set (HDF4_HDF_TESTSOURCE_DIR  ${HDF4_SOURCE_DIR}/hdf/test)
set (HDF4_MFHDFSOURCE_DIR     ${HDF4_SOURCE_DIR}/mfhdf/libsrc)
set (HDF4_MFHDF_TEST_DIR      ${HDF4_SOURCE_DIR}/mfhdf/test)
set (HDF4_MFHDF_FORTRAN_DIR   ${HDF4_SOURCE_DIR}/mfhdf/fortran)
set (HDF4_MFHDF_XDR_DIR       ${HDF4_SOURCE_DIR}/mfhdf/xdr)

if (NOT HDF4_INSTALL_BIN_DIR)
  set (HDF4_INSTALL_BIN_DIR bin)
  set (HDF4_INSTALL_UTILS_BIN_DIR ${HDF4_INSTALL_BIN_DIR}) #${HDF4_INSTALL_BIN_DIR}/utils
  set (HDF4_INSTALL_TOOLS_BIN_DIR ${HDF4_INSTALL_BIN_DIR}) #${HDF4_INSTALL_BIN_DIR}/tools
endif (NOT HDF4_INSTALL_BIN_DIR)
if (NOT HDF4_INSTALL_LIB_DIR)
  set (HDF4_INSTALL_LIB_DIR lib)
endif (NOT HDF4_INSTALL_LIB_DIR)
if (NOT HDF4_INSTALL_INCLUDE_DIR)
  set (HDF4_INSTALL_INCLUDE_DIR include)
endif (NOT HDF4_INSTALL_INCLUDE_DIR)
if (NOT HDF4_INSTALL_DATA_DIR)
  if (NOT WIN32)
    set (HDF4_INSTALL_DATA_DIR share)
    set (HDF4_INSTALL_CMAKE_DIR share/cmake)
  else (NOT WIN32)
    set (HDF4_INSTALL_DATA_DIR ".")
    set (HDF4_INSTALL_CMAKE_DIR cmake)
  endif (NOT WIN32)
endif (NOT HDF4_INSTALL_DATA_DIR)

#-----------------------------------------------------------------------------
# parse the full version number from hfile.h and include in H4_VERS_INFO
#-----------------------------------------------------------------------------
file (READ ${HDF4_HDFSOURCE_DIR}/hfile.h _hfile_h_contents)
string (REGEX REPLACE ".*#define[ \t]+LIBVER_MAJOR[ \t]+([0-9]*).*$"
    "\\1" H4_VERS_MAJOR ${_hfile_h_contents})
string (REGEX REPLACE ".*#define[ \t]+LIBVER_MINOR[ \t]+([0-9]*).*$"
    "\\1" H4_VERS_MINOR ${_hfile_h_contents})
string (REGEX REPLACE ".*#define[ \t]+LIBVER_RELEASE[ \t]+([0-9]*).*$"
    "\\1" H4_VERS_RELEASE ${_hfile_h_contents})
string (REGEX REPLACE ".*#define[ \t]+LIBVER_SUBRELEASE[ \t]+\"([0-9A-Za-z.]*)\".*$"
    "\\1" H4_VERS_SUBRELEASE ${_hfile_h_contents})
#message (STATUS "VERSION: ${H4_VERS_MAJOR}.${H4_VERS_MINOR}.${H4_VERS_RELEASE}-${H4_VERS_SUBRELEASE}")

#-----------------------------------------------------------------------------
# Basic HDF4 stuff here
#-----------------------------------------------------------------------------
set (HDF4_PACKAGE "hdf4")
set (HDF4_PACKAGE_NAME "HDF")
set (HDF4_PACKAGE_VERSION "${H4_VERS_MAJOR}.${H4_VERS_MINOR}.${H4_VERS_RELEASE}")
set (HDF4_PACKAGE_VERSION_MAJOR "${H4_VERS_MAJOR}.${H4_VERS_MINOR}")
set (HDF4_PACKAGE_VERSION_MINOR "${H4_VERS_RELEASE}")
set (HDF4_PACKAGE_VERSION_STRING "${HDF4_PACKAGE_VERSION}")
if (NOT "${H4_VERS_SUBRELEASE}" STREQUAL "")
  set (HDF4_PACKAGE_VERSION_STRING "${HDF4_PACKAGE_VERSION_STRING}-${H4_VERS_SUBRELEASE}")
endif (NOT "${H4_VERS_SUBRELEASE}" STREQUAL "")
set (HDF4_PACKAGE_STRING "${HDF4_PACKAGE_NAME} ${HDF4_PACKAGE_VERSION_STRING}")
set (HDF4_PACKAGE_TARNAME "${HDF4_PACKAGE}${HDF_PACKAGE_EXT}")
set (HDF4_PACKAGE_URL "http://www.hdfgroup.org")
set (HDF4_PACKAGE_BUGREPORT "help@hdfgroup.org")

#-----------------------------------------------------------------------------
# Include some macros for reusable code
#-----------------------------------------------------------------------------
include (${HDF_RESOURCES_EXT_DIR}/HDFMacros.cmake)
include (${HDF_RESOURCES_EXT_DIR}/HDFLibMacros.cmake)
include (${HDF_RESOURCES_DIR}/HDF4Macros.cmake)

#-----------------------------------------------------------------------------
# Setup output Directories
#-----------------------------------------------------------------------------
if (NOT HDF4_EXTERNALLY_CONFIGURED)
  set (CMAKE_RUNTIME_OUTPUT_DIRECTORY
      ${PROJECT_BINARY_DIR}/bin CACHE PATH "Single Directory for all Executables."
  )
  set (CMAKE_LIBRARY_OUTPUT_DIRECTORY
      ${PROJECT_BINARY_DIR}/bin CACHE PATH "Single Directory for all Libraries"
  )
  set (CMAKE_ARCHIVE_OUTPUT_DIRECTORY
      ${PROJECT_BINARY_DIR}/bin CACHE PATH "Single Directory for all static libraries."
  )
  set (CMAKE_Fortran_MODULE_DIRECTORY
      ${PROJECT_BINARY_DIR}/bin/fortran CACHE PATH "Single Directory for all fortran modules."
  )
else (NOT HDF4_EXTERNALLY_CONFIGURED)
  # if we are externally configured, but the project uses old cmake scripts
  # this may not be set and utilities like Hdetect will fail
  if (NOT CMAKE_RUNTIME_OUTPUT_DIRECTORY)
    set (CMAKE_RUNTIME_OUTPUT_DIRECTORY ${EXECUTABLE_OUTPUT_PATH})
  endif (NOT CMAKE_RUNTIME_OUTPUT_DIRECTORY)
endif (NOT HDF4_EXTERNALLY_CONFIGURED)

#-----------------------------------------------------------------------------
# Targets built within this project are exported at Install time for use
# by other projects using FindHDF4.
#-----------------------------------------------------------------------------
if (NOT HDF4_EXPORTED_TARGETS)
  set (HDF4_EXPORTED_TARGETS "hdf4-targets")
endif (NOT HDF4_EXPORTED_TARGETS)

#-----------------------------------------------------------------------------
# To include a library in the list exported by the project AT BUILD TIME,
# add it to this variable. This is NOT used by Make Install, but for projects
# which include hdf4 as a sub-project within their build tree
#-----------------------------------------------------------------------------
set_global_variable (HDF4_LIBRARIES_TO_EXPORT "")
set (EXTERNAL_HEADER_LIST "")
set (EXTERNAL_LIBRARY_LIST "")
set (EXTERNAL_LIBRARYDLL_LIST "")

#-----------------------------------------------------------------------------
# Run all the CMake configuration tests for our build environment
#-----------------------------------------------------------------------------
include (${HDF_RESOURCES_DIR}/ConfigureChecks.cmake)

set (CMAKE_INCLUDE_CURRENT_DIR_IN_INTERFACE ON)

#-----------------------------------------------------------------------------
# Option to Build Shared/Static libs, default is static
#-----------------------------------------------------------------------------
option (BUILD_SHARED_LIBS "Build Shared Libraries" OFF)
set (LIB_TYPE STATIC)
set (H4_ENABLE_SHARED_LIB NO)
set (H4_ENABLE_STATIC_LIB NO)
if (BUILD_SHARED_LIBS)
  set (LIB_TYPE SHARED)
  set (H4_BUILT_AS_DYNAMIC_LIB 1)
  set (H4_ENABLE_SHARED_LIB YES)
else (BUILD_SHARED_LIBS)
  set (H4_BUILT_AS_STATIC_LIB 1)
  set (H4_ENABLE_STATIC_LIB YES)
  set (CMAKE_POSITION_INDEPENDENT_CODE ON)
endif (BUILD_SHARED_LIBS)

add_definitions (-DBIG_LONGS -DSWAP)
add_definitions (-DHAVE_CONFIG_H)

#-----------------------------------------------------------------------------
# Temporary disable optimization flag
#-----------------------------------------------------------------------------
if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin" OR CYGWIN)
  foreach (flag_var
      CMAKE_C_FLAGS CMAKE_C_FLAGS_DEBUG CMAKE_C_FLAGS_RELEASE
      CMAKE_C_FLAGS_MINSIZEREL CMAKE_C_FLAGS_RELWITHDEBINFO
      CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE
      CMAKE_CXX_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_RELWITHDEBINFO)
    if (${flag_var} MATCHES "O3")
      string (REGEX REPLACE "O3" "O0" ${flag_var} "${${flag_var}}")
    endif (${flag_var} MATCHES "O3")
  endforeach (flag_var)
endif (${CMAKE_SYSTEM_NAME} MATCHES "Darwin" OR CYGWIN)

#-----------------------------------------------------------------------------
# Option to use code coverage
#-----------------------------------------------------------------------------
option (HDF4_ENABLE_COVERAGE "Enable code coverage for Libraries and Programs" OFF)
if (HDF4_ENABLE_COVERAGE)
    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -O0 -fprofile-arcs -ftest-coverage")
    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -O0 -fprofile-arcs -ftest-coverage")
    set (LDFLAGS "${LDFLAGS} -fprofile-arcs -ftest-coverage")   
endif (HDF4_ENABLE_COVERAGE)

#-----------------------------------------------------------------------------
# Option to use deprecated public API symbols
#-----------------------------------------------------------------------------
option (HDF4_ENABLE_DEPRECATED_SYMBOLS "Enable deprecated public API symbols" ON)
if (HDF4_ENABLE_DEPRECATED_SYMBOLS)
  set (H4_NO_DEPRECATED_SYMBOLS 0)   
else (HDF4_ENABLE_DEPRECATED_SYMBOLS)
  set (H4_NO_DEPRECATED_SYMBOLS 1)   
endif (HDF4_ENABLE_DEPRECATED_SYMBOLS)

#-----------------------------------------------------------------------------
# Include the main src and config directories
#-----------------------------------------------------------------------------
set (HDF4_INCLUDE_DIRECTORIES
    ${HDF4_HDFSOURCE_DIR} 
    ${HDF4_MFHDFSOURCE_DIR} 
    ${HDF4_SOURCE_DIR} 
    ${HDF4_BINARY_DIR}
    ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
)
INCLUDE_DIRECTORIES (${HDF4_INCLUDE_DIRECTORIES} )

#-----------------------------------------------------------------------------
# When building utility executables that generate other (source) files :
# we make use of the following variables defined in the root CMakeLists.
# Certain systems may add /Debug or /Release to output paths
# and we need to call the executable from inside the CMake configuration
#-----------------------------------------------------------------------------
set (EXE_EXT "")
if (WIN32)
  set (EXE_EXT ".exe")
  if (NOT CYGWIN)
    add_definitions (-D_BIND_TO_CURRENT_VCLIBS_VERSION=1)
    add_definitions (-D_CRT_SECURE_NO_WARNINGS)
    add_definitions (-D_CONSOLE)
  endif (NOT CYGWIN)
endif (WIN32)

if (MSVC)
  set (CMAKE_MFC_FLAG 0)
  set (WIN_COMPILE_FLAGS "")
  set (WIN_LINK_FLAGS "")
endif (MSVC)

set (MAKE_SYSTEM)
if (CMAKE_BUILD_TOOL MATCHES "make")
  set (MAKE_SYSTEM 1)
endif (CMAKE_BUILD_TOOL MATCHES "make")

set (CFG_INIT "/${CMAKE_CFG_INTDIR}")
if (MAKE_SYSTEM)
  set (CFG_INIT "")
endif (MAKE_SYSTEM)

#-----------------------------------------------------------------------------
# Add some definitions for Debug Builds
#-----------------------------------------------------------------------------
if (CMAKE_BUILD_TYPE MATCHES Debug)
  #-- NMake Makefiles will overwhelm the console with warnings if -Wall is used.
  if (NOT WIN32)
    add_definitions (-Wall)
  endif (NOT WIN32)
endif (CMAKE_BUILD_TYPE MATCHES Debug)

#-----------------------------------------------------------------------------
# Compiler specific flags : Shouldn't there be compiler tests for these
#-----------------------------------------------------------------------------
if (CMAKE_COMPILER_IS_GNUCC)
  if (CMAKE_BUILD_TYPE MATCHES Debug)
    set (CMAKE_C_FLAGS "${CMAKE_ANSI_CFLAGS} ${CMAKE_C_FLAGS} -std=c99 -finline-functions -fno-common")
  else (CMAKE_BUILD_TYPE MATCHES Debug)
    set (CMAKE_C_FLAGS "${CMAKE_ANSI_CFLAGS} ${CMAKE_C_FLAGS} -std=c99 -fomit-frame-pointer -finline-functions -fno-common")
  endif (CMAKE_BUILD_TYPE MATCHES Debug)
endif (CMAKE_COMPILER_IS_GNUCC)
if (CMAKE_COMPILER_IS_GNUCXX)
  if (CMAKE_BUILD_TYPE MATCHES Debug)
    set (CMAKE_CXX_FLAGS "${CMAKE_ANSI_CFLAGS} ${CMAKE_CXX_FLAGS} -finline-functions -fno-common")
  else (CMAKE_BUILD_TYPE MATCHES Debug)
    set (CMAKE_CXX_FLAGS "${CMAKE_ANSI_CFLAGS} ${CMAKE_CXX_FLAGS} -fomit-frame-pointer -finline-functions -fno-common")
  endif (CMAKE_BUILD_TYPE MATCHES Debug)
endif (CMAKE_COMPILER_IS_GNUCXX)

#-----------------------------------------------------------------------------
# Option to allow the user to disable compiler warnings
#-----------------------------------------------------------------------------
option (HDF4_DISABLE_COMPILER_WARNINGS "Disable compiler warnings" OFF)
if (HDF4_DISABLE_COMPILER_WARNINGS)
  # MSVC uses /w to suppress warnings.  It also complains if another
  # warning level is given, so remove it.
  if (MSVC)
    set (HDF4_WARNINGS_BLOCKED 1)
    string (REGEX REPLACE "(^| )([/-])W[0-9]( |$)" " " CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} /w")
    string (REGEX REPLACE "(^| )([/-])W[0-9]( |$)" " " CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /w")
  endif (MSVC)
  if (WIN32)
    add_definitions (-D_CRT_SECURE_NO_WARNINGS)
  endif (WIN32)
  # Borland uses -w- to suppress warnings.
  if (BORLAND)
    set (HDF4_WARNINGS_BLOCKED 1)
    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -w-")
  endif (BORLAND)

  # Most compilers use -w to suppress warnings.
  if (NOT HDF4_WARNINGS_BLOCKED)
    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -w")
    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -w")
  endif (NOT HDF4_WARNINGS_BLOCKED)
endif (HDF4_DISABLE_COMPILER_WARNINGS)

#-----------------------------------------------------------------------------
# This is in here to help some of the GCC based IDES like Eclipse
# and code blocks parse the compiler errors and warnings better.
#-----------------------------------------------------------------------------
if (CMAKE_COMPILER_IS_GNUCC)
  set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fmessage-length=0")
endif (CMAKE_COMPILER_IS_GNUCC)
if (CMAKE_COMPILER_IS_GNUCXX)
  set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fmessage-length=0")
endif (CMAKE_COMPILER_IS_GNUCXX)

#-----------------------------------------------------------------------------
# Option to Enable MPI Parallel
#-----------------------------------------------------------------------------
set (CMAKE_MODULE_PATH ${HDF_RESOURCES_DIR} ${HDF_RESOURCES_EXT_DIR} ${CMAKE_MODULE_PATH})
option (HDF4_ENABLE_PARALLEL "Enable parallel build (requires MPI)" OFF)
if (HDF4_ENABLE_PARALLEL)
  include (FindMPI)
  INCLUDE_DIRECTORIES (${MPI_C_INCLUDE_PATH})
  if (MPI_C_FOUND)
    set (H4_HAVE_PARALLEL 1)
    # MPI checks, only do these if MPI_C_FOUND is true, otherwise they always fail
    # and once set, they are cached as false and not regenerated
    set (CMAKE_REQUIRED_LIBRARIES "${MPI_C_LIBRARIES}" )
    CHECK_FUNCTION_EXISTS (MPI_File_get_size H4_HAVE_MPI_GET_SIZE) 
    # Used by Fortran + MPI
    CHECK_SYMBOL_EXISTS (MPI_Comm_c2f "${MPI_C_INCLUDE_PATH}/mpi.h"  H4_HAVE_MPI_MULTI_LANG_Comm)
    CHECK_SYMBOL_EXISTS (MPI_Info_c2f "${MPI_C_INCLUDE_PATH}/mpi.h"  H4_HAVE_MPI_MULTI_LANG_Info)
  else (MPI_C_FOUND)
    message (STATUS "Parallel libraries not found")
  endif (MPI_C_FOUND)
endif (HDF4_ENABLE_PARALLEL)

# Parallel IO usage requires MPI to be Linked and Included
if (H4_HAVE_PARALLEL)
  set (LINK_LIBS ${LINK_LIBS} ${MPI_C_LIBRARIES})
  if (MPI_C_LINK_FLAGS)
    set (CMAKE_EXE_LINKER_FLAGS "${MPI_C_LINK_FLAGS} ${CMAKE_EXE_LINKER_FLAGS}")
  endif (MPI_C_LINK_FLAGS)
endif (H4_HAVE_PARALLEL)

#-----------------------------------------------------------------------------
# Include user macros
#-----------------------------------------------------------------------------
include (UserMacros.cmake)

include (CMakeFilters.cmake)

#-----------------------------------------------------------------------------
# Option for external libraries on windows
#-----------------------------------------------------------------------------
option (HDF4_PACKAGE_EXTLIBS "CPACK - include external libraries" OFF)
if (NOT HDF4_EXTERNALLY_CONFIGURED)
  if (HDF4_PACKAGE_EXTLIBS)
    set (HDF4_NO_PACKAGES OFF CACHE BOOL "CPACK - Disable packaging" FORCE)
    if (HDF4_ENABLE_JPEG_LIB_SUPPORT AND JPEG_FOUND)
      PACKAGE_JPEG_LIBRARY (${HDF4_ALLOW_EXTERNAL_SUPPORT})
    endif (HDF4_ENABLE_JPEG_LIB_SUPPORT AND JPEG_FOUND)

    if (HDF4_ENABLE_Z_LIB_SUPPORT AND ZLIB_FOUND)
      PACKAGE_ZLIB_LIBRARY (${HDF4_ALLOW_EXTERNAL_SUPPORT})
    endif (HDF4_ENABLE_Z_LIB_SUPPORT AND ZLIB_FOUND)
    
    if (HDF4_ENABLE_SZIP_SUPPORT AND SZIP_FOUND)
      PACKAGE_SZIP_LIBRARY (${HDF4_ALLOW_EXTERNAL_SUPPORT})
    endif (HDF4_ENABLE_SZIP_SUPPORT AND SZIP_FOUND)
  endif (HDF4_PACKAGE_EXTLIBS)
endif (NOT HDF4_EXTERNALLY_CONFIGURED)

#-----------------------------------------------------------------------------
# Option to build HDF4 xdr Library
#-----------------------------------------------------------------------------
option (HDF4_BUILD_XDR_LIB  "Build HDF4 XDR Library" OFF)
if (WIN32 AND NOT MINGW)
  set (HDF4_BUILD_XDR_LIB ON CACHE BOOL "Build HDF4 XDR Library" FORCE)
endif (WIN32 AND NOT MINGW)

if (HDF4_BUILD_XDR_LIB)
  add_subdirectory (${HDF4_SOURCE_DIR}/mfhdf/xdr ${PROJECT_BINARY_DIR}/xdr)
endif (HDF4_BUILD_XDR_LIB)

#-----------------------------------------------------------------------------
# Add the HDF4 Library Target to the build
#-----------------------------------------------------------------------------
add_subdirectory (${HDF4_SOURCE_DIR}/hdf/src    ${PROJECT_BINARY_DIR}/hdf/src )
add_subdirectory (${HDF4_SOURCE_DIR}/mfhdf/libsrc   ${PROJECT_BINARY_DIR}/mfhdf/libsrc)

if (HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "SVN" OR HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "TGZ")
  if (JPEG_FOUND AND JPEG_USE_EXTERNAL)
    add_dependencies (${HDF4_SRC_LIB_TARGET} JPEG)
  endif (JPEG_FOUND AND JPEG_USE_EXTERNAL)
  if (ZLIB_FOUND AND ZLIB_USE_EXTERNAL)
    add_dependencies (${HDF4_SRC_LIB_TARGET} ZLIB)
  endif (ZLIB_FOUND AND ZLIB_USE_EXTERNAL)
  if (SZIP_FOUND AND SZIP_USE_EXTERNAL)
    add_dependencies (${HDF4_SRC_LIB_TARGET} SZIP)
  endif (SZIP_FOUND AND SZIP_USE_EXTERNAL)
endif (HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "SVN" OR HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "TGZ")

if (HDF4_BUILD_XDR_LIB)
  add_dependencies (${HDF4_MF_LIB_TARGET} ${HDF4_MF_XDR_LIB_TARGET})
endif (HDF4_BUILD_XDR_LIB)

#-----------------------------------------------------------------------------
# Dashboard and Testing Settings
#-----------------------------------------------------------------------------
option (BUILD_TESTING "Build HDF4 Unit Testing" OFF)
if (BUILD_TESTING)
  set (DART_TESTING_TIMEOUT 1200
      CACHE INTEGER
      "Timeout in seconds for each test (default 1200=20minutes)"
  )
  enable_testing ()
  include (CTest)
  if (NOT HDF4_EXTERNALLY_CONFIGURED)
    if (EXISTS "${HDF4_SOURCE_DIR}/hdf/test" AND IS_DIRECTORY "${HDF4_SOURCE_DIR}/hdf/test")
      add_subdirectory (${HDF4_SOURCE_DIR}/hdf/test   ${PROJECT_BINARY_DIR}/hdf/test)
    endif (EXISTS "${HDF4_SOURCE_DIR}/hdf/test" AND IS_DIRECTORY "${HDF4_SOURCE_DIR}/hdf/test")
    if (EXISTS "${HDF4_SOURCE_DIR}/mfhdf/test" AND IS_DIRECTORY "${HDF4_SOURCE_DIR}/mfhdf/test")
      add_subdirectory (${HDF4_SOURCE_DIR}/mfhdf/test ${PROJECT_BINARY_DIR}/mfhdf/test)
    endif (EXISTS "${HDF4_SOURCE_DIR}/mfhdf/test" AND IS_DIRECTORY "${HDF4_SOURCE_DIR}/mfhdf/test")
  endif (NOT HDF4_EXTERNALLY_CONFIGURED)
  include (${HDF4_SOURCE_DIR}/CTestConfig.cmake)
  configure_file (${HDF_RESOURCES_DIR}/CTestCustom.cmake ${HDF4_BINARY_DIR}/CTestCustom.ctest @ONLY)
endif (BUILD_TESTING)

#-----------------------------------------------------------------------------
# Option to build Fortran bindings/tests/examples
# Make sure this appears before the CONFIGURE_FILE step
# so that fortran name mangling is detected before writing H4config.h
#-----------------------------------------------------------------------------
# Set default name mangling : overridden by Fortran detection in fortran dir
set (H4_F77_FUNC "H4_F77_FUNC(name,NAME) name ## _")
set (H4_F77_FUNC_ "H4_F77_FUNC_(name,NAME) name ## __")
if (EXISTS "${HDF4_SOURCE_DIR}/mfhdf/fortran" AND IS_DIRECTORY "${HDF4_SOURCE_DIR}/mfhdf/fortran")
  option (HDF4_BUILD_FORTRAN "Build FORTRAN support" ON)
  if (HDF4_BUILD_FORTRAN)
    if (WIN32)
      set (H4_F77_FUNC "H4_F77_FUNC(name,NAME) NAME")
      set (H4_F77_FUNC_ "H4_F77_FUNC_(name,NAME) NAME")
    endif (WIN32)
    include (${HDF_RESOURCES_DIR}/HDF4UseFortran.cmake)
    add_subdirectory (${HDF4_SOURCE_DIR}/mfhdf/fortran ${PROJECT_BINARY_DIR}/mfhdf/fortran)
    add_subdirectory (${HDF4_SOURCE_DIR}/hdf/fortran ${PROJECT_BINARY_DIR}/hdf/fortran)
  endif (HDF4_BUILD_FORTRAN)
endif (EXISTS "${HDF4_SOURCE_DIR}/mfhdf/fortran" AND IS_DIRECTORY "${HDF4_SOURCE_DIR}/mfhdf/fortran")

if (MSVC OR MINGW)
  set (H4_HDSETVBUF "HDsetvbuf(F,S,M,Z) (((Z)>1)?setvbuf(F,S,M,Z):setvbuf(F,S,M,2))")
else (MSVC OR MINGW)
  set (H4_HDSETVBUF "NOP")
endif (MSVC OR MINGW)

#-----------------------------------------------------------------------------
# Library utilities
#-----------------------------------------------------------------------------
add_subdirectory (${HDF4_SOURCE_DIR}/hdf   ${PROJECT_BINARY_DIR}/hdf)
add_subdirectory (${HDF4_SOURCE_DIR}/mfhdf ${PROJECT_BINARY_DIR}/mfhdf)

#-----------------------------------------------------------------------------
# Option to build HDF4 Examples
#-----------------------------------------------------------------------------
if (EXISTS "${HDF4_SOURCE_DIR}/mfhdf/examples" AND IS_DIRECTORY "${HDF4_SOURCE_DIR}/mfhdf/examples")
  option (HDF4_BUILD_EXAMPLES  "Build HDF4 Examples" OFF)
  if (HDF4_BUILD_EXAMPLES)
    if (HDF4_BUILD_FORTRAN)
      if (EXISTS "${HDF4_SOURCE_DIR}/hdf/fortran/examples" AND IS_DIRECTORY "${HDF4_SOURCE_DIR}/hdf/fortran/examples")
        add_subdirectory (${HDF4_SOURCE_DIR}/hdf/fortran/examples     ${PROJECT_BINARY_DIR}/hdf/fortran/examples)
      endif (EXISTS "${HDF4_SOURCE_DIR}/hdf/fortran/examples" AND IS_DIRECTORY "${HDF4_SOURCE_DIR}/hdf/fortran/examples")
      if (EXISTS "${HDF4_SOURCE_DIR}/mfhdf/fortran/examples" AND IS_DIRECTORY "${HDF4_SOURCE_DIR}/mfhdf/fortran/examples")
        add_subdirectory (${HDF4_SOURCE_DIR}/mfhdf/fortran/examples     ${PROJECT_BINARY_DIR}/mfhdf/fortran/examples)
      endif (EXISTS "${HDF4_SOURCE_DIR}/mfhdf/fortran/examples" AND IS_DIRECTORY "${HDF4_SOURCE_DIR}/mfhdf/fortran/examples")
    endif (HDF4_BUILD_FORTRAN)

    add_subdirectory (${HDF4_SOURCE_DIR}/hdf/examples    ${PROJECT_BINARY_DIR}/hdf/examples)
    add_subdirectory (${HDF4_SOURCE_DIR}/mfhdf/examples    ${PROJECT_BINARY_DIR}/mfhdf/examples)
  endif (HDF4_BUILD_EXAMPLES)
endif (EXISTS "${HDF4_SOURCE_DIR}/mfhdf/examples" AND IS_DIRECTORY "${HDF4_SOURCE_DIR}/mfhdf/examples")

#-----------------------------------------------------------------------------
# Generate the H4config.h file containing user settings needed by compilation
#-----------------------------------------------------------------------------
configure_file (${HDF_RESOURCES_DIR}/h4config.h.in      ${PROJECT_BINARY_DIR}/h4config.h @ONLY)

include (CMakeInstallation.cmake)
