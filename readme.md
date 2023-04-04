

#windows

clone git repo.

run: sh build_submodules.sh

open this root folder in Visual Studio.

select x64-Release or x64-Debug.

menu > Build > Build All.

menu > Build > install wx_app.




#linux


clone git repo.

convert dos scripts to unix style:
find . -type f -iname "*.sh" -print0 |  xargs -0 dos2unix

run: sh build_submodules.sh


open this root folder in terminal.

mkdir build_x64
cd build_x64/
cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release ..
cmake --build . 
cmake --build . --target install



#note:
wxWidget in windows has 2 separate Debug and Release lib (Debug has 'd' in the end).
wxWidget in linux only has 1 identical Debug and Release lib (all omit 'd' in the end, see references). However, cmake export files are still different.
because of complexity in Linux to build and link to 32-bit version of gtk3, currently this repo only supports 64bit builds.


#references:

https://www.baeldung.com/linux/compile-32-bit-binary-on-64-bit-os

https://wiki.wxwidgets.org/Updating_to_the_Latest_Version_of_wxWidgets#Release_versus_Debug