
#-----------------------------------------------------------------------------
# Options for HDF4 Filters
#-----------------------------------------------------------------------------

include (ExternalProject)
#option (HDF4_ALLOW_EXTERNAL_SUPPORT "Allow External Library Building (NO SVN TGZ)" "NO")
set (HDF4_ALLOW_EXTERNAL_SUPPORT "NO" CACHE STRING "Allow External Library Building (NO SVN TGZ)")
set_property (CACHE HDF4_ALLOW_EXTERNAL_SUPPORT PROPERTY STRINGS NO SVN TGZ)
if (HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "SVN" OR HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "TGZ")
  option (JPEG_USE_EXTERNAL "Use External Library Building for JPEG" 1)
  option (ZLIB_USE_EXTERNAL "Use External Library Building for ZLIB" 1)
  option (SZIP_USE_EXTERNAL "Use External Library Building for SZIP" 1)
  if (HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "SVN")
    set (JPEG_URL ${JPEG_SVN_URL})
    set (ZLIB_URL ${ZLIB_SVN_URL})
    set (SZIP_URL ${SZIP_SVN_URL})
  elseif (HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "TGZ")
    if (NOT TGZPATH)
      set (TGZPATH ${HDF4_SOURCE_DIR})
    endif (NOT TGZPATH)
    set (JPEG_URL ${TGZPATH}/${JPEG_TGZ_NAME})
    set (ZLIB_URL ${TGZPATH}/${ZLIB_TGZ_NAME})
    set (SZIP_URL ${TGZPATH}/${SZIP_TGZ_NAME})
  else (HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "SVN")
    set (JPEG_USE_EXTERNAL 0)
    set (ZLIB_USE_EXTERNAL 0)
    set (SZIP_USE_EXTERNAL 0)
  endif (HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "SVN")
endif (HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "SVN" OR HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "TGZ")

#-----------------------------------------------------------------------------
# Option for LibJpeg support
#-----------------------------------------------------------------------------
option (HDF4_ENABLE_JPEG_LIB_SUPPORT "Enable libjpeg" ON)
if (HDF4_ENABLE_JPEG_LIB_SUPPORT)
  if (NOT H4_JPEGLIB_HEADER)
    if (NOT JPEG_USE_EXTERNAL)
      find_package (JPEG NAMES ${JPEG_PACKAGE_NAME}${HDF_PACKAGE_EXT})
      if (NOT JPEG_FOUND)
        find_package (JPEG) # Legacy find
      endif (NOT JPEG_FOUND)
    endif (NOT JPEG_USE_EXTERNAL)
    if (JPEG_FOUND)
      set (H4_HAVE_JPEGLIB_H 1)
      set (H4_HAVE_LIBJPEG 1)
      set (H4_JPEGLIB_HEADER "jpeglib.h")
      set (JPEG_INCLUDE_DIR_GEN ${JPEG_INCLUDE_DIR})
      set (JPEG_INCLUDE_DIRS ${JPEG_INCLUDE_DIR})
    else (JPEG_FOUND)
      if (HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "SVN" OR HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "TGZ")
        # May need to build JPEG with PIC on x64 machines with gcc
        # Need to use CMAKE_ANSI_CFLAGS define so that compiler test works
        if (BUILD_JPEG_WITH_PIC)
          set (JPEG_CMAKE_C_FLAGS "-fPIC")
        else (BUILD_JPEG_WITH_PIC)
          if (DEFINED CMAKE_ANSI_CFLAGS)
            set (JPEG_CMAKE_C_FLAGS ${CMAKE_ANSI_CFLAGS})
          else (DEFINED CMAKE_ANSI_CFLAGS)
            set (JPEG_CMAKE_C_FLAGS " ")
          endif (DEFINED CMAKE_ANSI_CFLAGS)
        endif (BUILD_JPEG_WITH_PIC)

        EXTERNAL_JPEG_LIBRARY (${HDF4_ALLOW_EXTERNAL_SUPPORT} ${LIB_TYPE} ${JPEG_CMAKE_C_FLAGS})
        set (H4_HAVE_JPEGLIB_H 1)
        set (H4_HAVE_LIBJPEG 1)
        set (H4_JPEGLIB_HEADER "jpeglib.h")
        message (STATUS "JPEGLIB is built")
      else (HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "SVN" OR HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "TGZ")
        message (FATAL_ERROR " JPEGLib is Required for JPEGLib support in HDF4")
      endif (HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "SVN" OR HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "TGZ")
    endif (JPEG_FOUND)
  else (NOT H4_JPEGLIB_HEADER)
    # This project is being called from within another and JPEGLib is already configured
    set (H4_HAVE_JPEGLIB_H 1)
  endif (NOT H4_JPEGLIB_HEADER)
  set (LINK_LIBS ${LINK_LIBS} ${JPEG_LIBRARY})
  INCLUDE_DIRECTORIES (${JPEG_INCLUDE_DIRS})
  message (STATUS "JPEGLIB is ON")
endif (HDF4_ENABLE_JPEG_LIB_SUPPORT)

#-----------------------------------------------------------------------------
# Option for ZLib support
#-----------------------------------------------------------------------------
option (HDF4_ENABLE_Z_LIB_SUPPORT "Enable Zlib Filters" ON)
if (HDF4_ENABLE_Z_LIB_SUPPORT)
  if (NOT H4_ZLIB_HEADER)
    if (NOT ZLIB_USE_EXTERNAL)
      find_package (ZLIB NAMES ${ZLIB_PACKAGE_NAME}${HDF_PACKAGE_EXT})
      if (NOT ZLIB_FOUND)
        find_package (ZLIB) # Legacy find
      endif (NOT ZLIB_FOUND)
    endif (NOT ZLIB_USE_EXTERNAL)
    if (ZLIB_FOUND)
      set (H4_HAVE_FILTER_DEFLATE 1)
      set (H4_HAVE_ZLIB_H 1)
      set (H4_HAVE_LIBZ 1)
      set (H4_ZLIB_HEADER "zlib.h")
      set (ZLIB_INCLUDE_DIR_GEN ${ZLIB_INCLUDE_DIR})
      set (ZLIB_INCLUDE_DIRS ${ZLIB_INCLUDE_DIR})
    else (ZLIB_FOUND)
      if (HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "SVN" OR HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "TGZ")
        EXTERNAL_ZLIB_LIBRARY (${HDF4_ALLOW_EXTERNAL_SUPPORT} ${LIB_TYPE})
        set (H4_HAVE_FILTER_DEFLATE 1)
        set (H4_HAVE_ZLIB_H 1)
        set (H4_HAVE_LIBZ 1)
        message (STATUS "Filter ZLIB is built")
      else (HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "SVN" OR HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "TGZ")
        message (FATAL_ERROR " ZLib is Required for ZLib support in HDF4")
      endif (HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "SVN" OR HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "TGZ")
    endif (ZLIB_FOUND)
  else (NOT H4_ZLIB_HEADER)
    # This project is being called from within another and ZLib is already configured
    set (H4_HAVE_FILTER_DEFLATE 1)
    set (H4_HAVE_ZLIB_H 1)
    set (H4_HAVE_LIBZ 1)
  endif (NOT H4_ZLIB_HEADER)
  set (LINK_LIBS ${LINK_LIBS} ${ZLIB_LIBRARIES})
  INCLUDE_DIRECTORIES (${ZLIB_INCLUDE_DIRS})
  message (STATUS "Filter ZLIB is ON")
endif (HDF4_ENABLE_Z_LIB_SUPPORT)

#-----------------------------------------------------------------------------
# Option for SzLib support
#-----------------------------------------------------------------------------
option (HDF4_ENABLE_SZIP_SUPPORT "Use SZip Filter" OFF)
set (SZIP_INFO "disabled")
if (HDF4_ENABLE_SZIP_SUPPORT)
  option (HDF4_ENABLE_SZIP_ENCODING "Use SZip Encoding" OFF)
  if (NOT SZIP_USE_EXTERNAL)
    find_package (SZIP NAMES ${SZIP_PACKAGE_NAME}${HDF_PACKAGE_EXT})
    if (NOT SZIP_FOUND)
      find_package (SZIP) # Legacy find
    endif (NOT SZIP_FOUND)
  endif (NOT SZIP_USE_EXTERNAL)
  if (SZIP_FOUND)
    set (H4_HAVE_FILTER_SZIP 1)
    set (H4_HAVE_SZLIB_H 1)
    set (H4_HAVE_LIBSZ 1)
    set (SZIP_INCLUDE_DIR_GEN ${SZIP_INCLUDE_DIR})
    set (SZIP_INCLUDE_DIRS ${SZIP_INCLUDE_DIR})
  else (SZIP_FOUND)
    if (HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "SVN" OR HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "TGZ")
      EXTERNAL_SZIP_LIBRARY (${HDF4_ALLOW_EXTERNAL_SUPPORT} ${LIB_TYPE} ${HDF4_ENABLE_SZIP_ENCODING})
      set (H4_HAVE_FILTER_SZIP 1)
      set (H4_HAVE_SZLIB_H 1)
      set (H4_HAVE_LIBSZ 1)
      message (STATUS "Filter SZIP is built")
    else (HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "SVN" OR HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "TGZ")
      message (FATAL_ERROR "SZIP is Required for SZIP support in HDF4")
    endif (HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "SVN" OR HDF4_ALLOW_EXTERNAL_SUPPORT MATCHES "TGZ")
  endif (SZIP_FOUND)
  set (LINK_LIBS ${LINK_LIBS} ${SZIP_LIBRARIES})
  INCLUDE_DIRECTORIES (${SZIP_INCLUDE_DIRS})
  message (STATUS "Filter SZIP is ON")
  if (HDF4_ENABLE_SZIP_ENCODING)
    set (H4_HAVE_SZIP_ENCODER 1)
    set (SZIP_INFO "enabled with encoder")
  else (HDF4_ENABLE_SZIP_ENCODING)
    set (SZIP_INFO "enabled with decoder only")
  endif (HDF4_ENABLE_SZIP_ENCODING)
endif (HDF4_ENABLE_SZIP_SUPPORT)