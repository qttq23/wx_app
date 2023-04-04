
# specify the C++ standard
cmake_minimum_required(VERSION 3.21)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

set(CMAKE_INSTALL_PREFIX "${CMAKE_BINARY_DIR}/install")
project(app)

# target
# NOTE: always regenerate (cmake ../) before build (cmake --build .) to get the newest list of source files.
# otherwise, the generated build folder doesnot know if new source files are added or removed.
set(TARGET_NAME App)
file(GLOB_RECURSE CPP_FILES ${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp)
if(WIN32) 
 add_executable(${TARGET_NAME} WIN32 ${CPP_FILES})
else()
 add_executable(${TARGET_NAME} ${CPP_FILES})
endif()

# set postfix
set_target_properties(${TARGET_NAME} PROPERTIES DEBUG_POSTFIX "_d")

# link libs
#target_link_libraries(${TARGET_NAME} PUBLIC Dll1 Dll2 Lib3)



### add wx

list(APPEND CMAKE_PREFIX_PATH 
	"${CMAKE_CURRENT_SOURCE_DIR}/../3rd/wxWidgets/build_${MY_ARC}\\install")
message(STATUS "CMAKE_PREFIX_PATH: ${CMAKE_PREFIX_PATH}")

find_package(wxWidgets REQUIRED COMPONENTS net core base)
if(wxWidgets_FOUND)
	message(STATUS "wxWidgets_FOUND")
	message(STATUS "wxWidgets_INCLUDE_DIRS: ${wxWidgets_INCLUDE_DIRS}")
	message(STATUS "wxWidgets_LIBRARIES: ${wxWidgets_LIBRARIES}")
	message(STATUS "wxWidgets_LIBRARY_DIRS: ${wxWidgets_LIBRARY_DIRS}")
	message(STATUS "wxWidgets_LIB_DIR: ${wxWidgets_LIB_DIR}")

	include(${wxWidgets_USE_FILE})
	target_link_libraries(${TARGET_NAME} PUBLIC ${wxWidgets_LIBRARIES})
endif()

### end add wx


# include dirs
target_include_directories(${TARGET_NAME} PUBLIC 
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    )

# define macros
target_compile_definitions(${TARGET_NAME} 
	PRIVATE "_CRT_SECURE_NO_WARNINGS")

# compiler options
set(warning_options
	"$<$<COMPILE_LANG_AND_ID:CXX,ARMClang,AppleClang,Clang,GNU,LCC>:-Wall;-Wextra;-Wshadow;-Wformat=2;-Wunused>"
	"$<$<COMPILE_LANG_AND_ID:CXX,MSVC>:/W3>")
target_compile_options(${TARGET_NAME} PRIVATE ${warning_options})



# for linux/unix
if(UNIX)
 if(NOT "${MY_ARC}" STREQUAL "x64")
  message(STATUS "building x86")
  message(STATUS "MY_ARC: ${MY_ARC}")
  target_compile_options(${TARGET_NAME} PRIVATE "-m32")
  target_link_options(${TARGET_NAME} PRIVATE "-m32")
 endif()
endif() 



# # install
string(CONCAT path_on_config 
  # ${TARGET_NAME}/ 
  $<$<CONFIG:Debug>:debug>
  $<$<CONFIG:Release>:release>
  # $<$<BOOL:${CMAKE_GENERATOR_PLATFORM}>:_${CMAKE_GENERATOR_PLATFORM}>
  )



install(TARGETS ${TARGET_NAME} 
	RUNTIME DESTINATION ${path_on_config}/bin
	)


# optimize ???
# currently just copy all wxWidgets DLLs to output
if(WIN32)
	install(DIRECTORY "${wxWidgets_LIB_DIR}/" DESTINATION "${path_on_config}/bin")
elseif(UNIX)

	install(DIRECTORY "${wxWidgets_LIBRARY_DIRS}/" DESTINATION "${path_on_config}/bin")
endif()


