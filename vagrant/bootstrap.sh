#!/usr/bin/env bash

echo "Installing base packages"
# yum install -y cmake epel-release
# yum install -y opencv opencv-devel mpich mpich-devel mpich-autoload qt qt-devel wget tcsh xauth xclock gcc-c++ mlocate time tree xorg-x11-fonts-* mesa-* python-pip python-wheel

yum install -y make gcc g++ wget gzip
echo "Installing singularity"

VERSION=2.2
wget https://github.com/singularityware/singularity/releases/download/$VERSION/singularity-$VERSION.tar.gz
tar xvf singularity-$VERSION.tar.gz
cd singularity-$VERSION
./configure --prefix=/usr/local
make
make install

