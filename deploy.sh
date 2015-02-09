#!/bin/sh -ex

VM=mir-tutorial.xen
KERNEL=`pwd`/xen/`cat xen/latest`
sed -e "s,@VM@,$VM,g; s,@KERNEL@,$KERNEL/$VM.xen,g" <xl.conf.in >$KERNEL/xl.conf

cd $KERNEL
rm -f $VM.xen
bunzip2 -k $VM.xen.bz2

sudo xl destroy $VM || true
sudo xl create xl.conf
