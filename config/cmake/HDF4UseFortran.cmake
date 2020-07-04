#
# This file provides functions for Fortran support.
#
#-------------------------------------------------------------------------------
enable_language (Fortran)
  
#-----------------------------------------------------------------------------
# Detect name mangling convention used between Fortran and C
#-----------------------------------------------------------------------------
include (FortranCInterface)
FortranCInterface_HEADER (
    ${CMAKE_BINARY_DIR}/F77Mangle.h
    MACRO_NAMESPACE "H4_F77_"
    SYMBOL_NAMESPACE "H4_F77_"
    SYMBOLS mysub mymod:my_sub
)

file (STRINGS ${CMAKE_BINARY_DIR}/F77Mangle.h CONTENTS REGEX "H4_F77_GLOBAL\\(.*,.*\\) +(.*)")
string (REGEX MATCH "H4_F77_GLOBAL\\(.*,.*\\) +(.*)" RESULT ${CONTENTS})
set (H4_F77_FUNC "H4_F77_FUNC(name,NAME) ${CMAKE_MATCH_1}")

file (STRINGS ${CMAKE_BINARY_DIR}/F77Mangle.h CONTENTS REGEX "H4_F77_GLOBAL_\\(.*,.*\\) +(.*)")
string (REGEX MATCH "H4_F77_GLOBAL_\\(.*,.*\\) +(.*)" RESULT ${CONTENTS})
set (H4_F77_FUNC_ "H4_F77_FUNC_(name,NAME) ${CMAKE_MATCH_1}")

#-----------------------------------------------------------------------------
# The provided CMake Fortran macros don't provide a general check function
# so this one is used for a sizeof test.
#-----------------------------------------------------------------------------
MACRO (CHECK_FORTRAN_FEATURE FUNCTION CODE VARIABLE)
  if (NOT DEFINED ${VARIABLE})
    message (STATUS "Testing Fortran ${FUNCTION}")
    if (CMAKE_REQUIRED_LIBRARIES)
      set (CHECK_FUNCTION_EXISTS_ADD_LIBRARIES
          "-DLINK_LIBRARIES:STRING=${CMAKE_REQUIRED_LIBRARIES}")
    else (CMAKE_REQUIRED_LIBRARIES)
      set (CHECK_FUNCTION_EXISTS_ADD_LIBRARIES)
    endif (CMAKE_REQUIRED_LIBRARIES)
    file (WRITE
        ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/testFortranCompiler.f
        "${CODE}"
    )
    try_compile (${VARIABLE}
        ${CMAKE_BINARY_DIR}
        ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/testFortranCompiler.f
        CMAKE_FLAGS "${CHECK_FUNCTION_EXISTS_ADD_LIBRARIES}"
        OUTPUT_VARIABLE OUTPUT
    )

#    message ( "* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ")
#    message ( "Test result ${OUTPUT}")
#    message ( "* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ")

    if (${VARIABLE})
      set (${VARIABLE} 1 CACHE INTERNAL "Have Fortran function ${FUNCTION}")
      message (STATUS "Testing Fortran ${FUNCTION} - OK")
      file (APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeOutput.log
          "Determining if the Fortran ${FUNCTION} exists passed with the following output:\n"
          "${OUTPUT}\n\n"
      )
    else (${VARIABLE})
      message (STATUS "Testing Fortran ${FUNCTION} - Fail")
      set (${VARIABLE} "" CACHE INTERNAL "Have Fortran function ${FUNCTION}")
      file (APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeError.log
          "Determining if the Fortran ${FUNCTION} exists failed with the following output:\n"
          "${OUTPUT}\n\n")
    endif (${VARIABLE})
  endif (NOT DEFINED ${VARIABLE})
ENDMACRO (CHECK_FORTRAN_FEATURE)

#-----------------------------------------------------------------------------
# Configure Checks which require Fortran compilation must go in here
# not in the main ConfigureChecks.cmake files, because if the user has
# no Fortran compiler, problems arise.
#
# Be careful with leading spaces here, do not remove them.
#-----------------------------------------------------------------------------
CHECK_FORTRAN_FEATURE(sizeof
  "
       PROGRAM main
       i = sizeof(x)
       END PROGRAM
  "
  FORTRAN_HAVE_SIZEOF
)

CHECK_FORTRAN_FEATURE(RealIsNotDouble
  "
       MODULE type_mod
         INTERFACE h4t
           MODULE PROCEDURE h4t_real
           MODULE PROCEDURE h4t_dble
         END INTERFACE
       CONTAINS
         SUBROUTINE h4t_real(r)
           REAL :: r
         END SUBROUTINE h4t_real
         SUBROUTINE h4t_dble(d)
           DOUBLE PRECISION :: d
         END SUBROUTINE h4t_dble
       END MODULE type_mod
       PROGRAM main
         USE type_mod
         REAL :: r
         DOUBLE PRECISION :: d
         CALL h4t(r)
         CALL h4t(d)
       END PROGRAM main
  "
  FORTRAN_DEFAULT_REAL_NOT_DOUBLE
)

#-----------------------------------------------------------------------------
# Add debug information (intel Fortran : JB)
#-----------------------------------------------------------------------------
if (CMAKE_Fortran_COMPILER MATCHES ifort)
    if (WIN32)
        set (CMAKE_Fortran_FLAGS_DEBUG "/debug:full /dbglibs " CACHE "flags" STRING FORCE)
        set (CMAKE_EXE_LINKER_FLAGS_DEBUG "/DEBUG" CACHE "flags" STRING FORCE)
    endif (WIN32)
endif (CMAKE_Fortran_COMPILER MATCHES ifort)
