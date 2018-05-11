#!/usr/bin/env bash

echo "Installing base packages"
yum -y update
yum install -y cmake epel-release git

yum install -y make gcc g++ wget gzip
echo "Installing singularity"

VERSION=2.2
wget https://github.com/singularityware/singularity/releases/download/$VERSION/singularity-$VERSION.tar.gz
tar xvf singularity-$VERSION.tar.gz
cd singularity-$VERSION
./configure --prefix=/usr/local
make
make install

