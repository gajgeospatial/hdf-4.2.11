cmake_minimum_required (VERSION 2.8.10)
PROJECT (HDF4_MFHDF_NCDUMP)

INCLUDE_DIRECTORIES (${HDF4_HDFSOURCE_DIR})
INCLUDE_DIRECTORIES (${HDF4_MFHDFSOURCE_DIR})

add_definitions (-DHDF)

if (WIN32)
  add_definitions (-DDOS_FS)
endif (WIN32)

if (HDF4_BUILD_XDR_LIB)
  if (WIN32)
    add_definitions (-DNO_SYS_XDR_INC)
  endif (WIN32)
  INCLUDE_DIRECTORIES (${HDF4_MFHDF_XDR_DIR})
endif (HDF4_BUILD_XDR_LIB)

set (ncdump_SRCS
    ${HDF4_MFHDF_NCDUMP_SOURCE_DIR}/dumplib.c
    ${HDF4_MFHDF_NCDUMP_SOURCE_DIR}/ncdump.c
    ${HDF4_MFHDF_NCDUMP_SOURCE_DIR}/vardata.c
    ${HDF4_SOURCE_DIR}/mfhdf/util/getopt.c
)
  
ADD_EXECUTABLE (ncdump ${ncdump_SRCS})
TARGET_C_PROPERTIES (ncdump " " " ")
if (HDF4_BUILD_XDR_LIB)
  target_link_libraries (ncdump ${HDF4_MF_LIB_TARGET} ${HDF4_SRC_LIB_TARGET} ${LINK_LIBS} ${HDF4_MF_XDR_LIB_TARGET} )
else (HDF4_BUILD_XDR_LIB)
  target_link_libraries (ncdump ${HDF4_MF_LIB_TARGET} ${HDF4_SRC_LIB_TARGET} ${LINK_LIBS})
endif (HDF4_BUILD_XDR_LIB)
TARGET_NAMING (ncdump ${LIB_TYPE})

if (BUILD_TESTING)
  include (CMakeTests.cmake)
endif (BUILD_TESTING)

##############################################################################
##############################################################################
###           I N S T A L L A T I O N                                      ###
##############################################################################
##############################################################################

#-----------------------------------------------------------------------------
# Add file(s) to CMake Install
#-----------------------------------------------------------------------------

INSTALL_PROGRAM_PDB (ncdump ${HDF4_INSTALL_TOOLS_BIN_DIR} toolsapplications)

INSTALL (
    TARGETS
        ncdump
    RUNTIME DESTINATION
        ${HDF4_INSTALL_TOOLS_BIN_DIR}
    COMPONENT
        toolsapplications
)


