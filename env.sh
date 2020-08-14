#!/bin/bash
#
# author: pan3yao@gmail.com
#

# 获取工作路径
homePath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo work dir [$homePath]

# 设置环境变量
export PATH=$homePath//nrt/bin/:$PATH LD_LIBRARY_PATH=$PWD/../nrt/lib/:$PWD/../nrt/lib64/
export LD_LIBRARY_PATH=$homePath/nrt/lib/:$homePath/nrt/lib64/:$LD_LIBRARY_PATH
export PKG_CONFIG_LIBDIR=$homePath/nrt/lib/pkgconfig/:$PKG_CONFIG_LIBDIR

echo '$PATH              -> '$PATH
echo '$LD_LIBRARY_PATH   -> '$LD_LIBRARY_PATH
echo '$PKG_CONFIG_LIBDIR -> '$PKG_CONFIG_LIBDIR
