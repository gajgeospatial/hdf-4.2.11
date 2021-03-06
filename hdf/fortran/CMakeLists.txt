cmake_minimum_required (VERSION 2.8.10)
PROJECT (HDF4_HDF_FORTRAN C CXX Fortran)

#-----------------------------------------------------------------------------
# Make sure generated files and modules are picked up correctly
#-----------------------------------------------------------------------------
INCLUDE_DIRECTORIES ( 
    ${CMAKE_Fortran_MODULE_DIRECTORY}
    ${HDF4_HDF_BINARY_DIR}
)
  
set (HDF4_HDF_SRC_CSTUB_FSRCS
    ${HDF4_HDFSOURCE_DIR}/dfanf.c
    ${HDF4_HDFSOURCE_DIR}/dff.c
    ${HDF4_HDFSOURCE_DIR}/dfpf.c
    ${HDF4_HDFSOURCE_DIR}/dfr8f.c
    ${HDF4_HDFSOURCE_DIR}/dfsdf.c
    ${HDF4_HDFSOURCE_DIR}/dfufp2i.c
    ${HDF4_HDFSOURCE_DIR}/dfutilf.c
    ${HDF4_HDFSOURCE_DIR}/df24f.c
    ${HDF4_HDFSOURCE_DIR}/dfufp2if.c
    ${HDF4_HDFSOURCE_DIR}/herrf.c
    ${HDF4_HDFSOURCE_DIR}/hfilef.c
    ${HDF4_HDFSOURCE_DIR}/mfanf.c
    ${HDF4_HDFSOURCE_DIR}/mfgrf.c
    ${HDF4_HDFSOURCE_DIR}/vattrf.c
    ${HDF4_HDFSOURCE_DIR}/vgf.c
)

set (HDF4_HDF_SRC_FHDRS
    ${HDF4_HDFSOURCE_DIR}/dffunc.inc
    ${HDF4_HDFSOURCE_DIR}/hdf.inc
)

SET_SOURCE_FILES_PROPERTIES (${HDF4_HDF_SRC_CSTUB_FSRCS} PROPERTIES LANGUAGE C) 

set (FORTRAN_SRC_DIR ${CMAKE_CURRENT_SOURCE_DIR})

#-----------------------------------------------------------------------------
# Add Main fortran library
#-----------------------------------------------------------------------------
add_library (${HDF4_SRC_FCSTUB_LIB_TARGET} ${LIB_TYPE} ${HDF4_HDF_SRC_CSTUB_FSRCS} ${HDF4_HDF_SRC_CHDRS} ${HDF4_HDFSOURCE_DIR}/hproto_fortran.h ${HDF4_BINARY_DIR}/h4config.h)
set_target_properties (${HDF4_SRC_FCSTUB_LIB_TARGET} PROPERTIES LINKER_LANGUAGE C)
if (WIN32)
  add_definitions (-DDOS_FS)
endif (WIN32)
TARGET_C_PROPERTIES (${HDF4_SRC_FCSTUB_LIB_TARGET} " " " ")
target_link_libraries (${HDF4_SRC_FCSTUB_LIB_TARGET} ${HDF4_SRC_LIB_TARGET})
set_global_variable (HDF4_LIBRARIES_TO_EXPORT "${HDF4_LIBRARIES_TO_EXPORT};${HDF4_SRC_FCSTUB_LIB_TARGET}")
H4_SET_LIB_OPTIONS (${HDF4_SRC_FCSTUB_LIB_TARGET} ${HDF4_SRC_FCSTUB_LIB_NAME} ${LIB_TYPE})

set (HDF4_F_FORTRAN_SRCS 
    ${HDF4_HDFSOURCE_DIR}/df24ff.f  
    ${HDF4_HDFSOURCE_DIR}/dfanff.f 
    ${HDF4_HDFSOURCE_DIR}/dfpff.f 
    ${HDF4_HDFSOURCE_DIR}/dfr8ff.f
    ${HDF4_HDFSOURCE_DIR}/dfsdff.f 
    ${HDF4_HDFSOURCE_DIR}/dfufp2iff.f
    ${HDF4_HDFSOURCE_DIR}/dfff.f 
    ${HDF4_HDFSOURCE_DIR}/hfileff.f 
    ${HDF4_HDFSOURCE_DIR}/mfgrff.f
    ${HDF4_HDFSOURCE_DIR}/vattrff.f 
    ${HDF4_HDFSOURCE_DIR}/vgff.f 
)
#-----------------------------------------------------------------------------
add_library (${HDF4_SRC_FORTRAN_LIB_TARGET} ${LIB_TYPE} ${HDF4_F_FORTRAN_SRCS})
set (SHARED_LINK_FLAGS " ")
if (WIN32)
  if (${LIB_TYPE} MATCHES "SHARED")
    if (MSVC)
      set (SHARED_LINK_FLAGS "/DLL /DEF:${HDF4_HDF_FORTRAN_SOURCE_DIR}/hdf_fortrandll.def")
    endif (MSVC)
  endif (${LIB_TYPE} MATCHES "SHARED")
endif (WIN32)
TARGET_FORTRAN_PROPERTIES (${HDF4_SRC_FORTRAN_LIB_TARGET} " " ${SHARED_LINK_FLAGS})
set_target_properties (${HDF4_SRC_FORTRAN_LIB_TARGET} PROPERTIES LINKER_LANGUAGE Fortran)
target_link_libraries (${HDF4_SRC_FORTRAN_LIB_TARGET} ${HDF4_SRC_FCSTUB_LIB_TARGET} ${LINK_LIBS})
set_global_variable (HDF4_LIBRARIES_TO_EXPORT "${HDF4_LIBRARIES_TO_EXPORT};${HDF4_SRC_FORTRAN_LIB_TARGET}")
H4_SET_LIB_OPTIONS (${HDF4_SRC_FORTRAN_LIB_TARGET} ${HDF4_SRC_FORTRAN_LIB_NAME} ${LIB_TYPE})
  
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
INSTALL (
    FILES
        ${HDF4_HDF_SRC_FHDRS}
    DESTINATION
        ${HDF4_INSTALL_INCLUDE_DIR}
    COMPONENT
        headers
)

#-----------------------------------------------------------------------------
# Add Target(s) to CMake Install for import into other projects
#-----------------------------------------------------------------------------
if (HDF4_EXPORTED_TARGETS)
  if (BUILD_SHARED_LIBS)
    INSTALL_TARGET_PDB (${HDF4_SRC_FCSTUB_LIB_TARGET} ${HDF4_INSTALL_LIB_DIR} fortlibraries)
    INSTALL_TARGET_PDB (${HDF4_SRC_FORTRAN_LIB_TARGET} ${HDF4_INSTALL_LIB_DIR} fortlibraries)
  endif (BUILD_SHARED_LIBS)
  
  INSTALL (
      TARGETS 
          ${HDF4_SRC_FCSTUB_LIB_TARGET}
          ${HDF4_SRC_FORTRAN_LIB_TARGET}
      EXPORT
          ${HDF4_EXPORTED_TARGETS}
      LIBRARY DESTINATION ${HDF4_INSTALL_LIB_DIR} COMPONENT fortlibraries 
      ARCHIVE DESTINATION ${HDF4_INSTALL_LIB_DIR} COMPONENT fortlibraries
      RUNTIME DESTINATION ${HDF4_INSTALL_BIN_DIR} COMPONENT fortlibraries
  )
endif (HDF4_EXPORTED_TARGETS)
    