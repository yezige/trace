# BestTrace 优化版

注意此 Shell 只适用于 Linux 平台，此优化版的特点：

- 使用短链接 `liu.app/s/trace` 更容易记忆
- 高亮并解释常规 ASN
- 支持传参，以查看任意 IP 的路由跳转情况

## 用法 1

分别测试如下路由跳转详情

```bash
curl liu.app/s/trace | bash
```

- 北京电信 北京联通 北京移动
- 上海电信 上海联通 上海移动
- 深圳电信 深圳联通 深圳移动
- 成都教育网

## 用法 2

支持测试入参 IP 的路由跳转详情，例如下方测试到`google.com`的路由跳转详情

```bash
wget liu.app/s/trace && sh trace google.com
```

## 相关截图

![screenshot](https://raw.githubusercontent.com/yezige/trace/master/images/screenshot.png)

## 遇到问题

- error: `socket: operation not permitted` 使用 sudo 或 root 权限即可

  - 用法 1: `curl liu.app/s/trace | sudo bash`
  - 用法 2: `wget liu.app/s/trace && sudo sh trace google.com`
