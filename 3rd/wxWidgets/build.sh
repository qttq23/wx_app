echo "build123_linux"

the_source=$(readlink -f ${BASH_SOURCE[0]})
the_dirname=$(dirname ${the_source})
pushd $the_dirname


mkdir -p build_x64
pushd build_x64

cmake -G "Visual Studio 17 2022" -A x64 ../source -DCMAKE_INSTALL_PREFIX=./install -DwxBUILD_SHARED=ON -DwxBUILD_SAMPLES=OFF -DwxBUILD_DEMOS=OFF -DwxUSE_GUI=ON 

cmake --build . --config Debug
cmake --build . --target install --config Debug


cmake --build . --config Release
cmake --build . --target install --config Release

popd 


# suspend build for 32bit because of complexity to link to 32bit lib (such as gtk3) in linux
: '
mkdir build_win32
pushd build_win32

cmake -G "Visual Studio 17 2022" -A Win32 ../source -DCMAKE_INSTALL_PREFIX=./install -DwxBUILD_SHARED=ON -DwxBUILD_SAMPLES=OFF -DwxBUILD_DEMOS=OFF -DwxUSE_GUI=ON 

cmake --build . --config Debug
cmake --build . --target install --config Debug


cmake --build . --config Release
cmake --build . --target install --config Release

popd 
'


popd 

