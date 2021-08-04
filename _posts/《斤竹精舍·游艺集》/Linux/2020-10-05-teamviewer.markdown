---
layout:     post
title:      "linux下安装向日葵和teamviewer"
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

### 向日葵
###### 安装
参考资料：[向日葵X for Linux Terminal 使用教程（命令行版本）](http://service.oray.com/question/11017.html)

### Teamviewer
###### 安装
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

**注意：**
1. 发现有时会与vnc冲突？所以导致出现不了图形界面（即便是用非图形界面安装）？能看到ID但用客户端控制的时候连接不上（一直显示“正在连接”）。这是因为第一次运行需要点击同意协议？还是因为需要设置自动同意连接（然而在[int32]里面设置了那个ACCEPT的也没效果诶）？反正就是有时不行


###### 参考资料
1. [CentOS 7 命令行安装TeamViewer](https://www.cnblogs.com/shenfeng/p/linux_cli_teamviewer.html)

![](/img/wc-tail.GIF)
