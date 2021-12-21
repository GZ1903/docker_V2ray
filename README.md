# XrayR

A Xray backend framework that can easily support many panels.

一个基于Xray的后端框架，支持V2ay,Trojan,Shadowsocks协议，极易扩展，支持多面板对接。

如果您喜欢本项目，可以右上角点个star+watch，持续关注本项目的进展。

使用教程：[详细使用教程](https://crackair.gitbook.io/xrayr-project/)

## 免责声明

本项目只是本人个人学习开发并维护，本人不保证任何可用性，也不对使用本软件造成的任何后果负责。

## 特点

- 永久开源且免费。
- 支持V2ray，Trojan， Shadowsocks多种协议。
- 支持Vless和XTLS等新特性。
- 支持单实例对接多面板、多节点，无需重复启动。
- 支持限制在线IP
- 支持节点端口级别、用户级别限速。
- 配置简单明了。
- 修改配置自动重启实例。
- 方便编译和升级，可以快速更新核心版本， 支持Xray-core新特性。

## 功能介绍

| 功能            | v2ray | trojan | shadowsocks |
| --------------- | ----- | ------ | ----------- |
| 获取节点信息    | √     | √      | √           |
| 获取用户信息    | √     | √      | √           |
| 用户流量统计    | √     | √      | √           |
| 服务器信息上报  | √     | √      | √           |
| 自动申请tls证书 | √     | √      | √           |
| 自动续签tls证书 | √     | √      | √           |
| 在线人数统计    | √     | √      | √           |
| 在线用户限制    | √     | √      | √           |
| 审计规则        | √     | √      | √           |
| 节点端口限速    | √     | √      | √           |
| 按照用户限速    | √     | √      | √           |
| 自定义DNS       | √     | √      | √           |

## 支持前端

| 前端                                                   | v2ray | trojan | shadowsocks                    |
| ------------------------------------------------------ | ----- | ------ | ------------------------------ |
| sspanel-uim                                            | √     | √      | √ (单端口多用户和V2ray-Plugin) |
| v2board                                                | √     | √      | √                              |
| [PMPanel](https://github.com/ByteInternetHK/PMPanel)   | √     | √      | √                              |
| [ProxyPanel](https://github.com/ProxyPanel/ProxyPanel) | √     | √      | ×                              |

## 软件安装

### 一键安装

```shell
yum -y install git && git clone https://gitee.com/gz1903/docker_soga.git /usr/local/src/docker_V2ray && cd /usr/local/src/docker_V2ray && chmod +x docker_V2ray.sh && ./docker_V2ray.sh
```

### 安装流程

![soga](https://cdn.jsdelivr.net/gh/gz1903/tu/V2ray.png)

需要填写信息：`前端ip或域名`、`对接的面板`、`对接的类型`、`通讯密钥`、`节点ID`

**以V2board为例：**

通讯密钥：

![soga](https://cdn.jsdelivr.net/gh/gz1903/tu/soga4.png)

编辑节点：

![soga](https://cdn.jsdelivr.net/gh/gz1903/tu/soga2.png)

节点管理：获取NodeID为4

![soga](https://cdn.jsdelivr.net/gh/gz1903/tu/soga3.png)

```shell
请输入V2board的IP或者域名（格式：http://x.x.x.x或者https://x.x.x.x）: http://192.168.120.128

请输入需要对接的后端，输入数字（1.V2board 2.SSpanel 3.PMpanel 4.Proxypanel）: 1
正在对接V2board，请稍等~

请输入需要后端对接类型，输入数字（1.V2ray 2.Shadowsocks 3.Trojan 4.Shadowsocks-Plugin）: 1
正在对接V2ray，请稍等~

请输入对接节点ID，Node_ID：4

请输入V2board与服务端通讯的密钥（或sspanel-Mukey）：12434539271243453927
```

