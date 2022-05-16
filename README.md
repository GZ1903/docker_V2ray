### 一键安装

```shell
git clone https://github.com/GZ1903/docker_V2ray.git /usr/local/src/docker_V2ray && cd /usr/local/src/docker_V2ray && chmod +x docker_V2ray.sh && ./docker_V2ray.sh
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

