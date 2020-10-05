---
layout:     post
title:      "常用linux命令总结"
subtitle:   ""
date:       2020-10-05 16:09:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Linux
    - 2020

---

### 安装
下载安装包：  
```
[root@centos7 ~]# wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
[root@centos7 ~]# wget https://download.teamviewer.com/download/linux/teamviewer-host.x86_64.rpm
```

安装yum源和TeamViewer (过程需要安装依赖包，选择y即可)：  
```
[root@centos7 ~]# yum install ./epel-release-latest-7.noarch.rpm
[root@centos7 ~]# yum install ./teamviewer-host*.rpm

```

进入默认安装目录、查看运行状态以获取连接ID、设置连接密码：  
```
[root@centos7 tv_bin]# cd /opt/teamviewer/tv_bin/
[root@centos7 tv_bin]# teamviewer --info
[root@centos7 tv_bin]# teamviewer --passwd 123456
```

### 参考资料
1. [CentOS 7 命令行安装TeamViewer](https://www.cnblogs.com/shenfeng/p/linux_cli_teamviewer.html)

![](/img/wc-tail.GIF)
