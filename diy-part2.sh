#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.123.222/g' package/base-files/files/bin/config_generate

# 修改时区
sed -i 's/UTC/CST-8/' package/base-files/files/bin/config_generate

#  修改默认语言
sed -i 's/option lang auto/option lang zh_cn/' feeds/luci/modules/luci-base/root/etc/config/luci

# Modify default theme
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 新增opt目录
mkdir package/base-files/files/opt
mkdir package/base-files/files/backup

# 修改Makefile文件，强制overlay格式化为ext4，使用openwrt官方脚本进行扩容
cp $GITHUB_WORKSPACE/3rd/package/system/fstools/Makefile package/system/fstools

# 新增AdGuardHome配置文件
cp -r $GITHUB_WORKSPACE/3rd/opt/AdGuardHome package/base-files/files/opt/
wget `curl -s https://api.github.com/repos/AdguardTeam/AdGuardHome/releases/latest | grep browser_download_url | cut -d'"' -f4 |grep linux_arm64` -O /tmp/AdGuardHome_linux_arm64.tar.gz
tar -zxvf /tmp/AdGuardHome_linux_arm64.tar.gz -C package/base-files/files/opt

# Modify hostname
sed -i 's/ImmortalWrt/r3s/g' package/base-files/files/bin/config_generate
