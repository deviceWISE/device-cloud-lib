#
# Copyright (C) 2017-2018 Wind River Systems, Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at:
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#
set( TARGET "${IOT_TARGET_UPDATE}" )

# Header files
set( IOT_HDRS_C ${IOT_HDRS_C}
	"update_main.h"
)

# Source files
set( IOT_SRCS_C ${IOT_SRCS_C}
	"update.c"
	"update_main.c"
)

# Resource files
if ( WIN32 )
	set( PROJECT_ICON "${PROJECT_RESOURCE_PATH_WIN32}/iot.ico" )

	configure_file(
		"${PROJECT_RESOURCE_PATH_WIN32}/version.rc.in"
		"${CMAKE_CURRENT_BINARY_DIR}/version.rc"
		@ONLY )
	set( IOT_RESOURCE_FILES "${CMAKE_CURRENT_BINARY_DIR}/version.rc" )
endif ( WIN32 )

add_executable( ${TARGET}
	${IOT_HDRS_C}
	${IOT_HDRS_CXX}
	${IOT_SRCS_C}
	${IOT_SRCS_CXX}
	${IOT_RESOURCE_FILES}
)

target_link_libraries( ${TARGET}
	${IOT_LIBRARY_NAME}
	iotutils
)

if( MSVC )
	# Compile MSVC runtime libraries into the output binary
	target_compile_options( "${TARGET}"
		PRIVATE "/MT$<$<CONFIG:Debug>:d>" )
endif( MSVC )

# Installation instructions
install( TARGETS ${TARGET}
	RUNTIME DESTINATION "${INSTALL_BIN_DIR}" COMPONENT core
)
