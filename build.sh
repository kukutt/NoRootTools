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

function test(){
    echo testtest
	endcheck "./test"
}

for arg in $*
	do
	echo "run $arg"
    $arg
done
