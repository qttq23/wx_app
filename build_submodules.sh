	

set -x

./module.sh 


unameOut=$(uname -a)
case "${unameOut}" in
    Linux*)     
        OS="Linux"
        ./3rd/wxWidgets/build_linux.sh
        ;;
    Darwin*)    
        OS="Mac"
        ;;
    MINGW*)     
        OS="Windows"
        ./3rd/wxWidgets/build.sh
        ;;
    *)          
        OS="UNKNOWN:${unameOut}"
esac

echo ${OS};

set +x