#!/bin/bash
apt install -y unzip
echo "开始安装爱影CMS最新版本"
rm -f iycms.zip;
wget --no-check-certificate "https://www.iycms.com/api/v1/download/cms/latest?os=1&kind=x86_64" -O iycms.zip
echo "解压文件"
unzip -o -q iycms.zip -d /home/iycms
rm -f iycms.zip
echo "开始安装系统服务"

echo "[Unit]
Description=iycms service
Documentation=https://www.iycms.com

[Service]
Type=simple
Restart=always
User=root
WorkingDirectory=/home/iycms/
ExecStart=/home/iycms/cms
RestartSec=1
StandardOutput=append:/home/iycms/stdout.log
StandardError=append:/home/iycms/stdout.log

[Install]
WantedBy=multi-user.target">/etc/systemd/system/iycms.service
systemctl daemon-reload
systemctl enable iycms
systemctl restart iycms
rm -f ./iycms.sh
systemctl stop ufw
systemctl disable ufw
echo "安装完成"