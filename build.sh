#!/bin/bash
#
# author: pan3yao@gmail.com
#

function help(){
    echo "help:"
    echo "    ./build gcc cmake"
}

function endcheck(){
    echo "check ${FUNCNAME[1]}"
    if [ ! -f $1 ];then
        echo "${FUNCNAME[1]} 编译失败"
        exit -1
    fi
}

function openssl(){
    [ -d "./openssl" ] || git clone https://github.com/openssl/openssl openssl
    pushd ./openssl
    ./config --prefix=$PWD/../nrt/
    make && make install
    popd
    endcheck "$PWD/nrt/bin/openssl"
}

function gcc(){
    [ -d "./gcc" ] || git clone git://gcc.gnu.org/git/gcc.git gcc
    pushd ./gcc
    git checkout releases/gcc-7.5.0
    ./contrib/download_prerequisites
    ./configure --prefix=$PWD/../mytools/ --enable-threads=posix --disable-multilib --enable-languages=c,c++
    make && make install
    popd
    endcheck "$PWD/nrt/bin/gcc"
}

function cmake(){
    [ -f "./cmake-3.18.1.tar.gz" ] || wget https://github.com/Kitware/CMake/releases/download/v3.18.1/cmake-3.18.1.tar.gz
    [ -d "./cmake-3.18.1" ] || tar -zxvf cmake-3.18.1.tar.gz
    pushd ./cmake-3.18.1
    ./configure --prefix=$PWD/../nrt/
    make && make install
    popd
    endcheck "$PWD/nrt/bin/cmake"
}

. ./env.sh

for arg in $*
do
	echo "run $arg"
    $arg
done


echo '环境变量1: PATH=$PWD/../nrt/bin/:$PATH LD_LIBRARY_PATH=$PWD/../nrt/lib/:$PWD/../nrt/lib64/'
echo '环境变量2: . ./evn.sh'
