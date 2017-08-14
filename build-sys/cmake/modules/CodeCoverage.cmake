#
# Code Coverage Support
#
# Enables code coverage support within the build system
#
# Copyright (C) 2015 Wind River Systems, Inc. All Rights Reserved.
#
# The right to copy, distribute or otherwise make use of this software may
# be licensed only pursuant to the terms of an applicable Wind River license
# agreement.  No license to Wind River intellectual property rights is granted
# herein.  All rights not licensed by Wind River are reserved by Wind River.
#

# Helper function to find a tool required for code coverage
#
# Parameters:
# - OUTPUT_VAR          name of the variable to output the result to
# - PROGRAM_NAME        name of the program
function( find_coverage_tool OUTPUT_VAR PROGRAM_NAME DESCRIPTION )
	find_program( ${OUTPUT_VAR}
		"${PROGRAM_NAME}"
		DOC "${PROGRAM_NAME}: ${DESCRIPTION}"
	)
	mark_as_advanced( ${OUTPUT_VAR} )
	if ( NOT ${OUTPUT_VAR} )
		message( FATAL_ERROR "${PROGRAM_NAME} not found! Aborting..." )
	endif( NOT ${OUTPUT_VAR} )
endfunction( find_coverage_tool )

# Set the correct compiler flags for the build
if ( CMAKE_C_COMPILER_ID MATCHES "(Clang|GNU)" )
	# Add coverage support
	set( CMAKE_C_FLAGS_COVERAGE "${CMAKE_C_FLAGS_DEBUG} -O0 -fprofile-arcs -ftest-coverage" )
	set( CMAKE_CXX_FLAGS_COVERAGE "${CMAKE_CXX_FLAGS_DEBUG} ${CMAKE_C_FLAGS_COVERAGE}" )
	set( CMAKE_CONFIGURATION_TYPES "${CMAKE_CONFIGURATION_TYPES} coverage" )
endif ( CMAKE_C_COMPILER_ID MATCHES "(Clang|GNU)" )

string( TOUPPER "${CMAKE_BUILD_TYPE}" CMAKE_BUILD_TYPE_UPPER )
if ( CMAKE_BUILD_TYPE_UPPER MATCHES "COVERAGE" )
	find_coverage_tool( GIT_COMMAND "git" "software revision control tool" )
	find_coverage_tool( LCOV_COMMAND "lcov" "gcov graphical front-end tool" )
	find_coverage_tool( GENHTML_COMMAND "genhtml" "HTML Generation tool" )

	if ( CMAKE_C_COMPILER_ID MATCHES "Clang" )
		find_coverage_tool( LLVM_COV_COMMAND "llvm-cov" "LLVM test coverage tool" )

		# Setup wrapper scripts to help with output generated by llvm-cov gcov
		set( LLVM_GCOV_SCRIPT "llvm-gcov.py" )
		set( LLVM_LCOV_SCRIPT "llvm-lcov.py" )
		# Create a temporary script by filing in the proper variable values
		configure_file(
			"${CMAKE_SOURCE_DIR}/build-sys/cmake/scripts/${LLVM_GCOV_SCRIPT}.in"
			"${CMAKE_BINARY_DIR}/CMakeFiles/CMakeTmp/${LLVM_GCOV_SCRIPT}" )
		configure_file(
			"${CMAKE_SOURCE_DIR}/build-sys/cmake/scripts/${LLVM_LCOV_SCRIPT}.in"
			"${CMAKE_BINARY_DIR}/CMakeFiles/CMakeTmp/${LLVM_LCOV_SCRIPT}" )
		# Ensure that the script has executable permissions
		file( COPY
			"${CMAKE_BINARY_DIR}/CMakeFiles/CMakeTmp/${LLVM_GCOV_SCRIPT}"
			"${CMAKE_BINARY_DIR}/CMakeFiles/CMakeTmp/${LLVM_LCOV_SCRIPT}"
			DESTINATION "${CMAKE_BINARY_DIR}"
			FILE_PERMISSIONS
			OWNER_READ OWNER_WRITE OWNER_EXECUTE
			GROUP_READ GROUP_EXECUTE
			WORLD_READ WORLD_EXECUTE
		)
		set( GCOV_WRAPPER "${CMAKE_BINARY_DIR}/${LLVM_GCOV_SCRIPT}" )
		set( LCOV_WRAPPER "${CMAKE_BINARY_DIR}/${LLVM_LCOV_SCRIPT}" )
	else() # GCC legacy support
		find_coverage_tool( GCOV_COMMAND "gcov" "Test coverage program" )
		set( GCOV_WRAPPER ${GCOV_COMMAND} )
		set( LCOV_WRAPPER ${LCOV_COMMAND} )
	endif ( CMAKE_C_COMPILER_ID MATCHES "Clang" )

	set( TEMP_COVERAGE_FILE "coverage.info" )
	add_custom_target( coverage
		DEPENDS tests
		COMMAND ${LCOV_WRAPPER} --gcov-tool=${GCOV_WRAPPER} --derive-func-data --directory . --zerocounters
		COMMAND ${CMAKE_CTEST_COMMAND} --output-on-failure
		COMMAND ${LCOV_WRAPPER} --gcov-tool=${GCOV_WRAPPER} --derive-func-data --directory . --capture --output-file ${TEMP_COVERAGE_FILE}
		COMMAND ${LCOV_WRAPPER} --gcov-tool=${GCOV_WRAPPER} --remove coverage.info "/usr/include/\\*" "/usr/local/include/\\*" "test/\\*" --output-file ${TEMP_COVERAGE_FILE}
		COMMAND ${GENHTML_COMMAND} --legend --title \"`${GIT_COMMAND} --git-dir \"${CMAKE_SOURCE_DIR}/.git\" log --format="%h;[%cr];-;%s" -1`\" --output-directory coverage ${TEMP_COVERAGE_FILE}
		COMMAND ${CMAKE_COMMAND} -E remove ${TEMP_COVERAGE_FILE}
		WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
	)
endif ( CMAKE_BUILD_TYPE_UPPER MATCHES "COVERAGE" )
