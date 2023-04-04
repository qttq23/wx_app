echo "build123"

the_source=$(readlink -f ${BASH_SOURCE[0]})
the_dirname=$(dirname ${the_source})
pushd $the_dirname


mkdir -p build_x64
pushd build_x64

cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug ../source -DCMAKE_INSTALL_PREFIX=./install -DwxBUILD_SHARED=ON -DwxBUILD_SAMPLES=OFF -DwxBUILD_DEMOS=OFF -DwxUSE_GUI=ON 
cmake --build . 
cmake --build . --target install

cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release ../source -DCMAKE_INSTALL_PREFIX=./install -DwxBUILD_SHARED=ON -DwxBUILD_SAMPLES=OFF -DwxBUILD_DEMOS=OFF -DwxUSE_GUI=ON
cmake --build .
cmake --build . --target install 

popd 

# suspend build for 32bit because of complexity to link to 32bit lib (such as gtk3) in linux
: '
mkdir build_win32
pushd build_win32

cmake -G "Unix Makefiles" -DCXXFLAGS=-m32 -DCMAKE_BUILD_TYPE=Debug ../source -DCMAKE_INSTALL_PREFIX=./install -DwxBUILD_SHARED=ON -DwxBUILD_SAMPLES=OFF -DwxBUILD_DEMOS=OFF -DwxUSE_GUI=ON 
cmake --build .
cmake --build . --target install

cmake -G "Unix Makefiles" -DCXXFLAGS=-m32 -DCMAKE_BUILD_TYPE=Release ../source -DCMAKE_INSTALL_PREFIX=./install -DwxBUILD_SHARED=ON -DwxBUILD_SAMPLES=OFF -DwxBUILD_DEMOS=OFF -DwxUSE_GUI=ON 
cmake --build . 
cmake --build . --target install

popd 
'

popd 

