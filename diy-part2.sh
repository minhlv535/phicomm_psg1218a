#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

cat >> .config <<EOF
	set luci.main.lang=auto
	commit luci
EOF

cat >> .config <<EOF
	del system.ntp
 set system.ntp=timeserver
        add_list system.ntp.server='0.asia.pool.ntp.org'
        add_list system.ntp.server='1.time.windows.com'
	set system.ntp.enabled=1
	set system.ntp.enable_server=1
commit system
  set luci.main.lang=auto
	set system.@system[0]=system
	set system.@system[0].zonename='Asia/Ho Chi Minh'
	set system.@system[0].timezone=ICT-7
	delete network.loopback
	set network.loopback='interface'
	set network.loopback.ifname='lo'
	set network.loopback.proto='static'
	set network.loopback.ipaddr='127.0.0.1'
	set network.loopback.netmask='255.0.0.0'
	/etc/init.d/sysntpd start >/dev/null
	set luci.diag.dns="google.com.vn"
	set luci.diag.ping="google.com.vn"
	set luci.diag.route="google.com.vn"
EOF

 cat >> .config <<EOF
 
CONFIG_PACKAGE_luci-app-unblockmusic is not set
CONFIG_UnblockNeteaseMusic_Go is not set
CONFIG_UnblockNeteaseMusic_NodeJS is not set
CONFIG_PACKAGE_luci-i18n-turboacc is not set
 
EOF

sed -i '/option disabled/d' /etc/config/wireless
sed -i 's/OpenWrt/Wi-Fi@/g' /etc/config/wireless

sed -i 's/192.168.1.1/172.16.1.1/g' /etc/config/network

sed -i '/DISTRIB_REVISION/d' /etc/openwrt_release
echo "DISTRIB_REVISION='OS'" >> /etc/openwrt_release
sed -i '/DISTRIB_DESCRIPTION/d' /etc/openwrt_release
echo "DISTRIB_DESCRIPTION='Router '" >> /etc/openwrt_release

sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' ./package/lean/default-settings/files/zzz-default-settings
