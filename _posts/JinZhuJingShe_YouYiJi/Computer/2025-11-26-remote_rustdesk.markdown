---
layout:     post
title:      "远程·RustDesk教程"
subtitle:   ""
date:       2025-11-26 21:57:00
author:     "XiLock"
header-img: "img/post-background/bamboo3.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - 2025


---

###### 日志文件查看
1. [官方：日志文件位置](https://github.com/rustdesk/rustdesk/wiki/FAQ#access-logs)
1. [Config files and logs文件位置](https://kb.unixservertech.com/software/rust/client): **Linux**: The configuration files appear to be located in the ` ~/.config/rustdesk` directory of the current user, while the log files are located in `~/.local/share/logs/RustDesk/`. Note that the commands to update the configuration must be run as the root user, with the result that they only modify the contects of `/root/.config/rustdesk`. It is possible to manually edit these files (RustDesk.toml and RustDesk2.toml), but always make a backup because the structure is not well documented, as far as I can tell so far. Copying the config files from one machine to another reportedly works well. I think you only need to copy RustDesk2.toml. **Microsoft Windows**: The config files for Windows are located in `C:\Users\username\AppData\Roaming\RustDesk\config\` and the log files are in `C:\Users\username\AppData\Roaming\RustDesk\log\` 


### Q&A 问题及解决

###### Failed to connect via rendezvous server: Please try later

1. 20251127更：xilock在用win系统控制连接校园网的电脑时，被控端为win系统时可以正常被控制，为ubuntu系统时提示"Failed to connect via rendezvous server: Please try later"，关闭Wayland后短暂连接成功一次，但没多久突然断，之后再也连接不上。后来测试发现问题出在ubuntu端，且ubuntu端可以正常ping到rs-ny.rustdesk.com，但`telnet rs-ny.rustdesk.com 21116`就提示`Trying 209.250.254.15...telnet: Unable to connect to remote host: Connection refused`，也就是ubuntu的链接请求被rustdesk的服务器拒绝了，因此xilock用zerotier组网+ip直连解决了该问题。
1. 20251202更：接上一条，xilock从zerotier上无意中注意到ubuntu端的physical ip是ipv4，而几个win系统的都是ipv4，尝试将ubuntu的ipv4调为优先之后rustdesk默认模式连接正常了，（猜测Ubuntu 系统默认是 IPv6 优先，如果本地网络设置为 IPv6 优先，而目标服务器仅支持 IPv4 或其 IPv6 配置存在问题，就可能导致连接异常。当尝试连接目标服务器时，系统会优先尝试通过 IPv6 进行连接，若目标服务器无法响应 IPv6 连接请求，就会出现连接失败的情况，即便 IPv4 可以正常连接目标服务器，也可能因为优先级问题而未被优先使用），然而改ipv4正常一会之后又连不上了，检查zerotier发现又跳回了ipv6，但即便再跳回ipv4也不能使用rustdesk默认模式连接了。WHY？？？


1. 20251202更：北京时间晚上23:00-第二天凌晨1:00的这段时间里rustdesk的网络不稳定？还是ubuntu端的BUCT内网对IP直连有限制？还是zerotier的服务器有限制？待核实

1.  [官网FAQ: Failed to connect via rendezvous server: Please try later](https://github.com/rustdesk/rustdesk/wiki/FAQ#failed-to-connect-via-rendezvous-server-please-try-later)
1. [Connection Error - Failed to connect via rendezvous server: Please try later #5817](https://github.com/rustdesk/rustdesk/discussions/5817)

###### connection error:os error 10054
1. [connection error:os error 10054](https://github.com/rustdesk/rustdesk/issues/1113#issuecomment-1200250142): the direct connection was established, but it is later forcely closed somehow (maybe security software). I manually modifed code to use relay connection, it is ok.
Solution: how to force using relay connection in this case (10054, switching wifi connection also has this problem per @21pages, he solved this by turn off/on wifi)?

###### The remote host forcibly closed an existing connection (erro 10054)
1. [The remote host forcibly closed an existing connection (erro 10054)](https://github.com/rustdesk/rustdesk/issues/106):Cause. Error 10054 occurs when the connection is reset by the peer application, usually due to an incorrect firewall configuration. Find more information about this error on Microsoft Development Center. Check the following items to ensure that your system, firewall and router are configured correctly.











![](/img/wc-tail.GIF)

