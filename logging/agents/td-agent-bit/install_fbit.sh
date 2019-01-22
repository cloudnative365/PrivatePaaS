#!/bin/bash
# Install td-agent-bit
# Author: eric.k.zhang@ericsson.se <Eric.Zhang>
# ChangeLog:
# 2019.01.22 scritp created, this is only for centos or rhel

# Import ENV
source /etc/profile

# Get yum repo
cat << EOF > /etc/yum.repos.d/td-agent-bit.repo
[td-agent-bit]
name = TD Agent Bit
baseurl = http://packages.fluentbit.io/centos/7
gpgcheck=1
gpgkey=http://packages.fluentbit.io/fluentbit.key
enabled=1
EOF

# Install
yum -y install td-agent-bit

# Config td-agent-bit
mkdir /var/log/td-agent-bit
touch /etc/td-agent-bit/plugins.conf
mkdir /etc/td-agent-bit/conf.d/

# Get config file from git
wget https://raw.githubusercontent.com/zhangke0516/PrivatePaaS/master/logging/agents/td-agent-bit/conf/td-agent-bit.conf -O /etc/td-agent-bit/td-agent-bit.conf
wget https://raw.githubusercontent.com/zhangke0516/PrivatePaaS/master/logging/agents/td-agent-bit/conf/conf.d/k8slog.app.conf -O /etc/td-agent-bit/conf.d/k8slog.app.conf
wget https://raw.githubusercontent.com/zhangke0516/PrivatePaaS/master/logging/agents/td-agent-bit/conf/conf.d/k8slog.core.conf -O /etc/td-agent-bit/conf.d/k8slog.core.conf
wget https://raw.githubusercontent.com/zhangke0516/PrivatePaaS/master/logging/agents/td-agent-bit/conf/conf.d/nginx.access.conf -O /etc/td-agent-bit/conf.d/nginx.access.conf
wget https://raw.githubusercontent.com/zhangke0516/PrivatePaaS/master/logging/agents/td-agent-bit/conf/conf.d/nginx.error.conf -O /etc/td-agent-bit/conf.d/nginx.error.conf
wget https://raw.githubusercontent.com/zhangke0516/PrivatePaaS/master/logging/agents/td-agent-bit/conf/conf.d/syslog.audit.conf -O /etc/td-agent-bit/conf.d/syslog.audit.conf
wget https://raw.githubusercontent.com/zhangke0516/PrivatePaaS/master/logging/agents/td-agent-bit/conf/conf.d/syslog.messages.conf -O /etc/td-agent-bit/conf.d/syslog.messages.conf

# systemctl
systemctl enable td-agent-bit
systemctl restart td-agent-bit
