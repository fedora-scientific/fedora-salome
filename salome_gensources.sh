#!/bin/bash
set -e

if [ ! -e .git ]; then
	echo "Execute this from within a git clone"
	exit 1
fi

if [ $# -lt 1 ]; then
	echo "Usage: $0 tag, i.e. $0 7_5_0a1"
	exit 1
fi

tag=$1
module=$(basename $PWD)
module=${module^^}
version=$(echo $tag | sed 's|_|.|g')

git checkout fedora_$tag
patches=$(git format-patch tags/V$tag)

rm -f ../*.patch
rm -f ../*.tar.gz

git archive --prefix=${module}_SRC_${version}/ -o ../${module}_SRC_${version}.tar.gz tags/V$tag
mv $patches ..
echo "Wrote:"
echo "${module}_SRC_${version}.tar.gz"
echo "$patches"