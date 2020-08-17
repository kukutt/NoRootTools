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
        echo "${FUNCNAME[1]} 编译失败, 找不到编译成果物 $1"
        exit -1
    fi
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

function openssl(){
    [ -d "./openssl" ] || git clone https://github.com/openssl/openssl openssl
    pushd ./openssl
    ./config --prefix=$PWD/../nrt/
    make && make install
    popd
    endcheck "$PWD/nrt/bin/openssl"
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

function ffmpeg(){
    [ -d "./x264" ] || git clone http://git.videolan.org/git/x264.git
    pushd ./x264 
    git checkout db0d417728460c647ed4a847222a535b00d3dbcb
    ./configure --prefix=$PWD/../nrt/ --disable-asm --enable-shared
    make && make install
    popd
    endcheck "$PWD/nrt/bin/ffmpeg"

    [ -f "./x265_3.2.tar.gz" ] || wget http://download.videolan.org/videolan/x265/x265_3.2.tar.gz
    [ -d "./x265_3.2" ] || tar -zxvf x265_3.2.tar.gz
    pushd ./x265_3.2
    cmake -DCMAKE_INSTALL_PREFIX=$PWD/../nrt/ source
    make && make install
    popd
    endcheck "$PWD/nrt/bin/ffmpeg"

    [ -d "./ffmpeg" ] || git clone https://git.ffmpeg.org/ffmpeg.git
    pushd ./ffmpeg
    git checkout n4.3.1
    ./configure --prefix=$PWD/../nrt/ --enable-shared --disable-static --disable-x86asm --disable-doc --enable-libx264 --enable-libx265 --enable-gpl --extra-cflags="-I$PWD/../nrt/include/" --extra-ldflags="-L$PWD/../nrt/lib/"
    make && make install
    popd
    endcheck "$PWD/nrt/bin/ffmpeg"
}

. ./env.sh

for arg in $*
do
	echo "run $arg"
    $arg
done


echo '环境变量1: PATH=$PWD/../nrt/bin/:$PATH LD_LIBRARY_PATH=$PWD/../nrt/lib/:$PWD/../nrt/lib64/'
echo '环境变量2: . ./evn.sh'
