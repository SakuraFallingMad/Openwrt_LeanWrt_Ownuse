#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

# Add prepareCompile
disablePkgsList="
./feeds/luci/applications/luci-app-softethervpn
./feeds/luci/themes/luci-theme-argon
./feeds/packages/net/adguardhome
./feeds/packages/net/mosdns
./feeds/small8/diy
./feeds/small8/luci-app-argon-config
./feeds/small8/luci-theme-argon
./feeds/small8/mbedtls
./feeds/small8/my-default-settings
./feeds/small8/vsftpd-alt
./feeds/small8/openwrt-app-actions
"

function disableDulicatedPkg()
{
	if [ -d $1 ];then
		rm -rf $1
		echo $1" Disabled."
	fi
}

git pull
./scripts/feeds update -a

for disablePkg in $disablePkgsList
do
	disableDulicatedPkg $disablePkg
done

./scripts/feeds update -i
./scripts/feeds install -a
