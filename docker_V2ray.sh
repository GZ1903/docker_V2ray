#!/bin/sh
#
#Date:2021.12.21
#Author:GZ
#Mail:V2board@qq.com

process()
{
install_date="XrayR_LuFly_$(date +%Y-%m-%d_%H:%M:%S).log"
printf "
\033[36m#######################################################################
#                     欢迎使用XrayR一键对接脚本                       #
#                脚本适配环境CentOS7+/RetHot7+、内存1G+               #
#                更多信息请访问 https://gz1903.github.io              #
#######################################################################\033[0m
"

echo -e "\033[36m#######################################################################\033[0m"
echo -e "\033[36m#                                                                     #\033[0m"
echo -e "\033[36m#                  正在安装基础组件  请稍等~                          #\033[0m"
echo -e "\033[36m#                                                                     #\033[0m"
echo -e "\033[36m#######################################################################\033[0m"
yum -y install wget curl

echo -e "\033[36m#######################################################################\033[0m"
echo -e "\033[36m#                                                                     #\033[0m"
echo -e "\033[36m#                  正在同步时间  请稍等~                              #\033[0m"
echo -e "\033[36m#                                                                     #\033[0m"
echo -e "\033[36m#######################################################################\033[0m"
yum -y install ntpdate
timedatectl set-timezone Asia/Shanghai
ntpdate ntp1.aliyun.com

echo -e "\033[36m#######################################################################\033[0m"
echo -e "\033[36m#                                                                     #\033[0m"
echo -e "\033[36m#                  正在配置防火墙  请稍等~                            #\033[0m"
echo -e "\033[36m#                                                                     #\033[0m"
echo -e "\033[36m#######################################################################\033[0m"
systemctl start supervisord
systemctl disable firewalld
systemctl stop firewalld

echo -e "\033[36m#######################################################################\033[0m"
echo -e "\033[36m#                                                                     #\033[0m"
echo -e "\033[36m#                  正在安装docker  时间较长请稍等~                    #\033[0m"
echo -e "\033[36m#                                                                     #\033[0m"
echo -e "\033[36m#######################################################################\033[0m"
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce docker-ce-cli containerd.io -y
systemctl start docker
systemctl enable docker
# 安装Docker-compose
curl -fsSL https://get.docker.com | bash -s docker
curl -L "https://github.com/docker/compose/releases/download/1.26.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo -e "\033[36m#######################################################################\033[0m"
echo -e "\033[36m#                                                                     #\033[0m"
echo -e "\033[36m#                  正在部署docker  时间较长请稍等~                    #\033[0m"
echo -e "\033[36m#                                                                     #\033[0m"
echo -e "\033[36m#######################################################################\033[0m"
yum install -y git
rm -rf /usr/local/src/XrayR-release
git clone https://github.com/XrayR-project/XrayR-release /usr/local/src/XrayR-release
cd /usr/local/src/XrayR-release
wget --no-check-certificate https://raw.githubusercontent.com/supermalio/docker/main/rico-docker.sh && chmod +x  rico-docker.sh && bash rico-docker.sh

while :; do echo
    read -p "请输入V2board的IP或者域名（格式：http://x.x.x.x或者https://x.x.x.x）: " appip 
    [ -n "$appip" ] && break
done

while :; do echo
 read -p "请输入需要对接的后端，输入数字（1.V2board 2.SSpanel 3.PMpanel 4.Proxypanel）: " version 
 if [ "$version" = "1" ]; then
 	vs=V2board
     echo 正在对接$vs，请稍等~
	break
 fi
 if [ "$version" = "2" ]; then
	vs=SSpanel
     echo 正在对接$vs，请稍等~
	break
 fi
 if [ "$version" = "3" ]; then
	vs=PMpanel
     echo 正在对接$vs，请稍等~
	break

 elif [ "$version" = "4" ]; then
	vs=Proxypanel
     echo 正在对接$vs，请稍等~
	break
 fi
done

while :; do echo
 read -p "请输入需要后端对接类型，输入数字（1.V2ray 2.Shadowsocks 3.Trojan 4.Shadowsocks-Plugin）: " types
 if [ "$types" = "1" ]; then
	ts=V2ray
     echo 正在对接$ts，请稍等~
	break
 fi
 if [ "$types" = "2" ]; then
	ts=Shadowsocks
     echo 正在对接$ts，请稍等~
	break
 fi
 if [ "$types" = "3" ]; then
	ts=Trojan
     echo 正在对接$ts，请稍等~
	break
 elif [ "$types" = "4" ]; then
	ts=Shadowsocks-Plugin
     echo 正在对接$ts，请稍等~
	break
 fi
done

while :; do echo
    read -p "请输入对接节点ID，Node_ID：" id
    [ -n "$id" ] && break
done

while :; do echo
    read -p "请输入V2board与服务端通讯的密钥（或sspanel-Mukey）：" mk
    [ -n "$mk" ] && break
done

cd /usr/local/src/XrayR-release/config
cp -i /usr/local/src/XrayR-release/config/config.yml{,.bak}
cat > /usr/local/src/XrayR-release/config/config.yml <<eof
Log:
  Level: none # Log level: none, error, warning, info, debug 
  AccessPath: # /etc/XrayR/access.Log
  ErrorPath: # /etc/XrayR/error.log
DnsConfigPath: # /etc/XrayR/dns.json # Path to dns config, check https://xtls.github.io/config/base/dns/ for help
RouteConfigPath: # /etc/XrayR/route.json # Path to route config, check https://xtls.github.io/config/base/route/ for help
OutboundConfigPath: # /etc/XrayR/custom_outbound.json # Path to custom outbound config, check https://xtls.github.io/config/base/outbound/ for help
ConnetionConfig:
  Handshake: 4 # Handshake time limit, Second
  ConnIdle: 30 # Connection idle time limit, Second
  UplinkOnly: 2 # Time limit when the connection downstream is closed, Second
  DownlinkOnly: 4 # Time limit when the connection is closed after the uplink is closed, Second
  BufferSize: 64 # The internal cache size of each connection, kB 
Nodes:
  -
    PanelType: "$vs" # Panel type: SSpanel, V2board, PMpanel, , Proxypanel
    ApiConfig:
      ApiHost: "$appip"
      ApiKey: "$mk"
      NodeID: $id
      NodeType: $ts # Node type: V2ray, Shadowsocks, Trojan, Shadowsocks-Plugin
      Timeout: 30 # Timeout for the api request
      EnableVless: false # Enable Vless for V2ray Type
      EnableXTLS: false # Enable XTLS for V2ray and Trojan
      SpeedLimit: 0 # Mbps, Local settings will replace remote settings, 0 means disable
      DeviceLimit: 0 # Local settings will replace remote settings, 0 means disable
      RuleListPath: # ./rulelist Path to local rulelist file
    ControllerConfig:
      ListenIP: 0.0.0.0 # IP address you want to listen
      SendIP: 0.0.0.0 # IP address you want to send pacakage
      UpdatePeriodic: 60 # Time to update the nodeinfo, how many sec.
      EnableDNS: false # Use custom DNS config, Please ensure that you set the dns.json well
      DNSType: AsIs # AsIs, UseIP, UseIPv4, UseIPv6, DNS strategy
      EnableProxyProtocol: false # Only works for WebSocket and TCP
      EnableFallback: false # Only support for Trojan and Vless
      FallBackConfigs:  # Support multiple fallbacks
        -
          SNI: # TLS SNI(Server Name Indication), Empty for any
          Path: # HTTP PATH, Empty for any
          Dest: 80 # Required, Destination of fallback, check https://xtls.github.io/config/fallback/ for details.
          ProxyProtocolVer: 0 # Send PROXY protocol version, 0 for dsable
      CertConfig:
        CertMode: dns # Option about how to get certificate: none, file, http, dns. Choose "none" will forcedly disable the tls config.
        CertDomain: "node1.test.com" # Domain to cert
        CertFile: ./cert/node1.test.com.cert # Provided if the CertMode is file
        KeyFile: ./cert/node1.test.com.key
        Provider: alidns # DNS cert provider, Get the full support list here: https://go-acme.github.io/lego/dns/
        Email: test@me.com
        DNSEnv: # DNS ENV option used by DNS provider
          ALICLOUD_ACCESS_KEY: aaa
          ALICLOUD_SECRET_KEY: bbb
  # -
  #   PanelType: "V2board" # Panel type: SSpanel, V2board
  #   ApiConfig:
  #     ApiHost: "http://127.0.0.1:668"
  #     ApiKey: "123"
  #     NodeID: 4
  #     NodeType: Shadowsocks # Node type: V2ray, Shadowsocks, Trojan
  #     Timeout: 30 # Timeout for the api request
  #     EnableVless: false # Enable Vless for V2ray Type
  #     EnableXTLS: false # Enable XTLS for V2ray and Trojan
  #     SpeedLimit: 0 # Mbps, Local settings will replace remote settings
  #     DeviceLimit: 0 # Local settings will replace remote settings
  #   ControllerConfig:
  #     ListenIP: 0.0.0.0 # IP address you want to listen
  #     UpdatePeriodic: 10 # Time to update the nodeinfo, how many sec.
  #     EnableDNS: false # Use custom DNS config, Please ensure that you set the dns.json well
  #     CertConfig:
  #       CertMode: dns # Option about how to get certificate: none, file, http, dns
  #       CertDomain: "node1.test.com" # Domain to cert
  #       CertFile: ./cert/node1.test.com.cert # Provided if the CertMode is file
  #       KeyFile: ./cert/node1.test.com.pem
  #       Provider: alidns # DNS cert provider, Get the full support list here: https://go-acme.github.io/lego/dns/
  #       Email: test@me.com
  #       DNSEnv: # DNS ENV option used by DNS provider
  #         ALICLOUD_ACCESS_KEY: aaa
  #         ALICLOUD_SECRET_KEY: bbb
eof


echo -e "\033[36m#######################################################################\033[0m"
echo -e "\033[36m#                                                                     #\033[0m"
echo -e "\033[36m#                  正在启动  请稍等~                                  #\033[0m"
echo -e "\033[36m#                                                                     #\033[0m"
echo -e "\033[36m#######################################################################\033[0m"

cd /usr/local/src/XrayR-release/config && /usr/local/bin/docker-compose up -d

echo $?="对接已完成"

# 清除缓存垃圾
# rm -rf /usr/local/src/XrayR-release
rm -rf /usr/local/src/docker_V2ray

echo -e "\033[32m--------------------------- 已完成 ---------------------------\033[0m"
echo -e "\033[32m 文件目录     :/usr/local/src/XrayR-release\033[0m"
echo -e "\033[32m 安装日志文件 :/var/log/"$install_date
echo -e "\033[32m------------------------------------------------------------------\033[0m"
echo -e "\033[32m 如果安装有问题请反馈安装日志文件。\033[0m"
echo -e "\033[32m 使用有问题请在这里寻求帮助:https://gz1903.github.io\033[0m"
echo -e "\033[32m 电子邮箱:v2board@qq.com\033[0m"
echo -e "\033[32m------------------------------------------------------------------\033[0m"
}
LOGFILE=/var/log/"XrayR_LuFly_$(date +%Y-%m-%d_%H:%M:%S).log"
touch $LOGFILE
tail -f $LOGFILE &
pid=$!
exec 3>&1
exec 4>&2
exec &>$LOGFILE
process
ret=$?
exec 1>&3 3>&-
exec 2>&4 4>&-\


