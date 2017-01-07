#!/bin/sh
# This script created by AQEMU
/usr/bin/qemu-system-i386  -enable-kvm -m 2048 -localtime -hda "/run/media/alex/New_data/data/qemu/win7/win7.qcow2" -net nic,vlan=0 -net user,vlan=0 -name "Windows 7" -vnc :10 $*
