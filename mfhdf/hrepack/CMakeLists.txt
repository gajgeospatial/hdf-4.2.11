cmake_minimum_required (VERSION 2.8.10)
PROJECT (HDF4_MFHDF_HREPACK)

INCLUDE_DIRECTORIES (${HDF4_HDFSOURCE_DIR})
INCLUDE_DIRECTORIES (${HDF4_MFHDFSOURCE_DIR})
INCLUDE_DIRECTORIES (${HDF4_SOURCE_DIR}/mfhdf/hdiff)

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

set (hrepack_SRCS
    ${HDF4_MFHDF_HREPACK_SOURCE_DIR}/hrepack.c
    ${HDF4_MFHDF_HREPACK_SOURCE_DIR}/hrepack_an.c
    ${HDF4_MFHDF_HREPACK_SOURCE_DIR}/hrepack_gr.c
    ${HDF4_MFHDF_HREPACK_SOURCE_DIR}/hrepack_list.c
    ${HDF4_MFHDF_HREPACK_SOURCE_DIR}/hrepack_lsttable.c
    ${HDF4_MFHDF_HREPACK_SOURCE_DIR}/hrepack_main.c
    ${HDF4_MFHDF_HREPACK_SOURCE_DIR}/hrepack_opttable.c
    ${HDF4_MFHDF_HREPACK_SOURCE_DIR}/hrepack_parse.c
    ${HDF4_MFHDF_HREPACK_SOURCE_DIR}/hrepack_sds.c
    ${HDF4_MFHDF_HREPACK_SOURCE_DIR}/hrepack_utils.c
    ${HDF4_MFHDF_HREPACK_SOURCE_DIR}/hrepack_vg.c
    ${HDF4_MFHDF_HREPACK_SOURCE_DIR}/hrepack_vs.c
    ${HDF4_MFHDF_HREPACK_SOURCE_DIR}/hrepack_dim.c
)
  
ADD_EXECUTABLE (hrepack ${hrepack_SRCS})
TARGET_C_PROPERTIES (hrepack " " " ")
if (HDF4_BUILD_XDR_LIB)
  target_link_libraries (hrepack ${HDF4_MF_LIB_TARGET} ${HDF4_SRC_LIB_TARGET} ${LINK_LIBS} ${HDF4_MF_XDR_LIB_TARGET})
else (HDF4_BUILD_XDR_LIB)
  target_link_libraries (hrepack ${HDF4_MF_LIB_TARGET} ${HDF4_SRC_LIB_TARGET} ${LINK_LIBS})
endif (HDF4_BUILD_XDR_LIB)
TARGET_NAMING (hrepack ${LIB_TYPE})
  
ADD_EXECUTABLE (hrepack_check ${HDF4_MFHDF_HREPACK_SOURCE_DIR}/hrepack_check.c)
TARGET_C_PROPERTIES (hrepack_check " " " ")
if (HDF4_BUILD_XDR_LIB)
  target_link_libraries (hrepack_check ${HDF4_MF_LIB_TARGET} ${HDF4_SRC_LIB_TARGET} ${LINK_LIBS} ${HDF4_MF_XDR_LIB_TARGET})
else (HDF4_BUILD_XDR_LIB)
  target_link_libraries (hrepack_check ${HDF4_MF_LIB_TARGET} ${HDF4_SRC_LIB_TARGET} ${LINK_LIBS})
endif (HDF4_BUILD_XDR_LIB)
TARGET_NAMING (hrepack_check ${LIB_TYPE})

if (BUILD_TESTING)
  include (CMakeTests.cmake)
endif (BUILD_TESTING)

##############################################################################
##############################################################################
###           I N S T A L L A T I O N                                      ###
##############################################################################
##############################################################################

#-----------------------------------------------------------------------------
# Rules for Installation of tools using make Install target
#-----------------------------------------------------------------------------

INSTALL_PROGRAM_PDB (hrepack ${HDF4_INSTALL_TOOLS_BIN_DIR} toolsapplications)

INSTALL (
    TARGETS
        hrepack hrepack_check
    RUNTIME DESTINATION
        ${HDF4_INSTALL_TOOLS_BIN_DIR}
    COMPONENT
        toolsapplications
)
