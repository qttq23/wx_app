
# specify the C++ standard
cmake_minimum_required(VERSION 3.21)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

set(CMAKE_INSTALL_PREFIX "${CMAKE_BINARY_DIR}/install")
project(wx_app)



# linux
set(MY_ARC "" CACHE STRING "Architecture to tell gcc. needed in linux")


if(WIN32)

 # -A Win32/ x64
 if(CMAKE_GENERATOR_PLATFORM)
  set(MY_ARC "${CMAKE_GENERATOR_PLATFORM}")
 else()
  set(MY_ARC "x64")
 endif()

 # Debug/Release
 set(CMAKE_CONFIGURATION_TYPES Debug Release) 
 

elseif(UNIX)

 # Win32/x64
 if( "-m32" IN_LIST CMAKE_CXX_FLAGS)
  set(MY_ARC "Win32")
 else()
  set(MY_ARC "x64")
 endif()

 # Release/Debug
 if(CMAKE_BUILD_TYPE)
 endif()

endif()




# below order is important 
add_subdirectory(app)


