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
1.  [官网FAQ: Failed to connect via rendezvous server: Please try later](https://github.com/rustdesk/rustdesk/wiki/FAQ#failed-to-connect-via-rendezvous-server-please-try-later)
1. [Connection Error - Failed to connect via rendezvous server: Please try later #5817](https://github.com/rustdesk/rustdesk/discussions/5817)
1. xilock在用win系统控制连接校园网的电脑时，被控端为win系统时可以正常被控制，为ubuntu系统时提示"Failed to connect via rendezvous server: Please try later"，关闭Wayland后短暂连接成功一次，但没多久突然断

###### connection error:os error 10054
1. [connection error:os error 10054](https://github.com/rustdesk/rustdesk/issues/1113#issuecomment-1200250142): the direct connection was established, but it is later forcely closed somehow (maybe security software). I manually modifed code to use relay connection, it is ok.
Solution: how to force using relay connection in this case (10054, switching wifi connection also has this problem per @21pages, he solved this by turn off/on wifi)?

###### The remote host forcibly closed an existing connection (erro 10054)
1. [The remote host forcibly closed an existing connection (erro 10054)](https://github.com/rustdesk/rustdesk/issues/106):Cause. Error 10054 occurs when the connection is reset by the peer application, usually due to an incorrect firewall configuration. Find more information about this error on Microsoft Development Center. Check the following items to ensure that your system, firewall and router are configured correctly.











![](/img/wc-tail.GIF)

