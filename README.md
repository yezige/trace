# BestTrace Optimized

[简体中文](https://github.com/yezige/trace/blob/main/README_zh.md) | [English](https://github.com/yezige/trace/blob/main/README.md)

Note that this shell is only applicable to the Linux platform, the features of this optimized version:

- Use the short link `liu.app/s/trace` to be easier to remember
- Highlight and explain regular ASNs
- Support passing parameters to view the routing jump of any IP

## Usage 1

Test the following route jump details separately.

```bash
curl liu.app/s/trace | bash
```

|                           |                 |                 |
| ------------------------- | --------------- | --------------- |
| Beijing Telecom           | Beijing Unicom  | Beijing Mobile  |
| Shanghai Telecom          | Shanghai Unicom | Shanghai Mobile |
| Shenzhen Telecom          | Shenzhen Unicom | Shenzhen Mobile |
| Chengdu Education Network |                 |                 |

## Usage 2

Supports testing the details of the route jump of the input IP, for example, the details of the route jump to `google.com` tested below.

```bash
wget liu.app/s/trace && sh trace google.com
```

## Screenshot

![screenshot](https://raw.githubusercontent.com/yezige/trace/master/images/screenshot.png)

## Something wrong

- error: `socket: operation not permitted` Use sudo or root permission

  - Usage 1: `curl liu.app/s/trace | sudo bash`
  - Usage 2: `wget liu.app/s/trace && sudo sh trace google.com`
