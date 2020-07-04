# Install script for directory: D:/Development/op3d_active/hdf-4.2.11/hdf/src

# Set the install prefix
IF(NOT DEFINED CMAKE_INSTALL_PREFIX)
  SET(CMAKE_INSTALL_PREFIX "C:/Program Files (x86)/HDF4")
ENDIF(NOT DEFINED CMAKE_INSTALL_PREFIX)
STRING(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
IF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  IF(BUILD_TYPE)
    STRING(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  ELSE(BUILD_TYPE)
    SET(CMAKE_INSTALL_CONFIG_NAME "Release")
  ENDIF(BUILD_TYPE)
  MESSAGE(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
ENDIF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)

# Set the component getting installed.
IF(NOT CMAKE_INSTALL_COMPONENT)
  IF(COMPONENT)
    MESSAGE(STATUS "Install component: \"${COMPONENT}\"")
    SET(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  ELSE(COMPONENT)
    SET(CMAKE_INSTALL_COMPONENT)
  ENDIF(COMPONENT)
ENDIF(NOT CMAKE_INSTALL_COMPONENT)

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "headers")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE FILE FILES
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/atom.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/bitvect.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/cdeflate.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/cnbit.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/cnone.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/crle.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/cskphuff.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/cszip.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/df.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/dfan.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/dfgr.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/dfrig.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/dfi.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/dfsd.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/dfstubs.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/dfufp2i.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/dynarray.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/glist.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/H4api_adpt.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/hbitio.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/hchunks.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/hcomp.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/hcompi.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/hconv.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/hdatainfo.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/hdf.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/hdfi.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/herr.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/hfile.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/hkit.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/hlimits.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/hntdefs.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/hproto.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/hqueue.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/htags.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/linklist.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/mcache.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/mfan.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/mfgr.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/mstdio.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/tbbt.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/vattr.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/vg.h"
    "D:/Development/op3d_active/hdf-4.2.11/hdf/src/vgint.h"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "headers")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "libraries")
  IF("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "D:/Development/op3d_active/hdf-4.2.11/msvc/bin//hdf.pdb")
  ENDIF("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "libraries")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "libraries")
  IF("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "D:/Development/op3d_active/hdf-4.2.11/msvc/bin/Debug/hdf_D.lib")
  ELSEIF("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "D:/Development/op3d_active/hdf-4.2.11/msvc/bin/Release/hdf.lib")
  ELSEIF("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "D:/Development/op3d_active/hdf-4.2.11/msvc/bin/MinSizeRel/hdf.lib")
  ELSEIF("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY OPTIONAL FILES "D:/Development/op3d_active/hdf-4.2.11/msvc/bin/RelWithDebInfo/hdf.lib")
  ENDIF()
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "libraries")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "libraries")
  IF("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE SHARED_LIBRARY FILES "D:/Development/op3d_active/hdf-4.2.11/msvc/bin/Debug/hdf_D.dll")
  ELSEIF("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE SHARED_LIBRARY FILES "D:/Development/op3d_active/hdf-4.2.11/msvc/bin/Release/hdf.dll")
  ELSEIF("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE SHARED_LIBRARY FILES "D:/Development/op3d_active/hdf-4.2.11/msvc/bin/MinSizeRel/hdf.dll")
  ELSEIF("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE SHARED_LIBRARY FILES "D:/Development/op3d_active/hdf-4.2.11/msvc/bin/RelWithDebInfo/hdf.dll")
  ENDIF()
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "libraries")

