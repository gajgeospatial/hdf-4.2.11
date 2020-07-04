#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "xdr" for configuration "Debug"
set_property(TARGET xdr APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(xdr PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/lib/xdr_D.lib"
  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "ws2_32.lib"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/bin/xdr_D.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS xdr )
list(APPEND _IMPORT_CHECK_FILES_FOR_xdr "${_IMPORT_PREFIX}/lib/xdr_D.lib" "${_IMPORT_PREFIX}/bin/xdr_D.dll" )

# Import target "hdf" for configuration "Debug"
set_property(TARGET hdf APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(hdf PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/lib/hdf_D.lib"
  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "D:/Development/op3d_active/jpeg-9/vc110/Win32/Release/jpeg.lib;D:/Development/op3d_active/zlib-1.2.8/vc110/Win32/Release/zlib.lib"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/bin/hdf_D.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS hdf )
list(APPEND _IMPORT_CHECK_FILES_FOR_hdf "${_IMPORT_PREFIX}/lib/hdf_D.lib" "${_IMPORT_PREFIX}/bin/hdf_D.dll" )

# Import target "mfhdf" for configuration "Debug"
set_property(TARGET mfhdf APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(mfhdf PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/lib/mfhdf_D.lib"
  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "xdr;hdf"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/bin/mfhdf_D.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS mfhdf )
list(APPEND _IMPORT_CHECK_FILES_FOR_mfhdf "${_IMPORT_PREFIX}/lib/mfhdf_D.lib" "${_IMPORT_PREFIX}/bin/mfhdf_D.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
