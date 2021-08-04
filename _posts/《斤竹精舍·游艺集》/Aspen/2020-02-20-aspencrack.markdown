---
layout:     post
title:      "aspen 8.0 Install"
subtitle:   ""
date:       2020-02-20 09:57:00
author:     "XiLock"
header-img: "img/post-background/bamboo3.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - aspen
    - 2019


---
申明：本教程和涉及到的软件只做学习交流使用， 请24小时内删除或购买正版。

### Sentinel.RMS.8.5.1.Server
1. 安装install_Sentinel.RMS.8.5.1.Server，一路next即可；
1. 创建一个新的**“系统变量”**（不是用户变量），变量名为“计算机名”，变量值为aspenv10.slf的文件路径，如“D:\license\aspen.slf”；
1. 将Tool文件夹复制于install_Sentinel.RMS.8.5.1.Server下，以管理员身份打开其中的WlmAdmin.exe；Subnet Servers > 右键点击你的计算机名 > add Featrue > From a File > To Server and its File；添加“D:\license\aspen.slf”文件，等待30min左右，完成后会添加3130个许可;(如有意外，Subnet Servers > 右键点击你的计算机名 > remove all Feature，然后再重新添加一次这个许可文件。)

### 基层组件
确保已安装以下Aspen所需组件
1. Microsoft.NET Framework 3.5 SP1 
1. Microsoft.NET Framework4 
1. Microsoft SQL Express 2012 SP1

确认“Windows功能”里的以下功能前面为对勾：
1. Internet Information Services可承载的Web核心；
1. Internet信息服务；
1. Microsoft.NET Framework 3.5.1；
1. Microsoft Message Queue (MSMQ)服务器

### Aspen安装
未必安装在C盘，D盘等其他盘也都可以。  
1. 管理员身份运行1- LicGen.exe生成lic文件（注意：解压后会自动运行AspenSuite2006_LicGen.exe，但该过程生成的lic文件可能有问题，**建议删掉自动生成的lic文件，重新用管理员模式运行AspenSuite2006_LicGen.exe来生成lic文件**）；
1. 加载AspenONEV8.4DVD1.iso，运行setup1.exe，安装32位aspen即可（即便是64位电脑也建议安装32位），安装过程中需要添加licence时browse之前生成lic文件，一直到安装完成；（有时用Custom Install来少安一些东西的时候完事会缺一些东西以至于破解失败或使用报错，实在不行就直接用Typical Install）
1. 将AspenONEV8.4\Patch\2-STRGXI2.zip里的STRGXI2.dll文件复制到C:\Program Files (x86)\Common Files\AspenTech Shared（替换）和C:\Program Files (x86)\Common Files\Hyprotech\Shared；
1. 将之前生成的lic文件复制到C:\Program Files (x86)\Common Files\AspenTech Shared（替换）和C:\Program Files (x86)\Common Files\Hyprotech\Shared；
1. 打开Aspen puls并new一个流程看看能不能用，如果licence报错，尝试用Common Utilities下的SLM Configuration Wizard和SLM License Profiler重新加载一下自己生成的lic文件（确保是以管理员身份运行解压后的AspenSuite2006_LicGen.exe生成的，而非只是管理员模式运行1- LicGen.exe自动生成的）；
1. 不行就再用Sentinel.RMS.8.5.1.Server破解一遍（重新破解前记得先将之前的东西抹掉：remove all Feature）；
1. 再不行就卸载了Sentinel.RMS.8.5.1.Server以后重新安装Sentinel.RMS.8.5.1.Server再破解；


### Q&A
1. 使用Sentinel.RMS.8.5.1.Server时遇到“The system cannot retrieve the servers, there is no response to the broadcast.”一般是因为修改了计算机名，可参照[这篇文章](https://gateway.sdl.com/apex/communityknowledge?articleName=000005725)来解决问题。
1. “not able to successfully connect to any of the database and will not be able to use them in this simulation”的时候重新挂载一下Datebase，即：程序—— AspenTech——Process Modeling V8.4——Aspen Properties——
Aspen Properties Datebase Configuration Tester打开后点一下`Start`；（中间可能要两次点击start，中间过程自动配置好，本条参考AspenOneV8安装教程）

### 说明
1. 该破解方法适用于10.0及以前版本。破解虚拟机时，WlmAdmin那部可能耗时1.5小时左右。
1. 对于8.4版本，破解有效期为30天？故取消同步时间并在vmx文件中加入时间锁定参数（[参考资料](https://vinf.net/2012/02/23/how-to-set-a-virtual-machine-to-a-date-in-the-past-and-make-it-stay-there/)）。但虚尝试过多种方法后均不能实现关闭客户机的条件下锁定虚拟机时间，故以后不在虚拟机里关机（即不关闭客户机），而是选择挂起（即挂起客户机），这样下次打开还是挂起时的时间。(关机再重新启动，主虚拟机的时间在下次启动时又会回到配置文件中的时间（但xilock设定的配置文件里的时间一直没有起作用），可能会有一些对象（上次启动后生成的对象）生成在未来的时间，这样会出问题。所以在你需要重启或关闭宿主机时，请将虚拟机挂起。)

### 参考资料
1. [aspen万能安装视频教程（文末已经附安装视频教程，可以直接观看）- 化工资料共享平台](https://mp.weixin.qq.com/s?__biz=MzU1NDMxNzcyNQ==&mid=100001153&idx=1&sn=cc6f7d80ed0cbaf751dfd6ba4ff94a90&chksm=7be427734c93ae652d127966aa889b2e93ff440f4c658c0d0799eec98e87a6cea21628450ddb&mpshare=1&scene=1&srcid=&sharer_sharetime=1582019430143&sharer_shareid=64054a1e645e8c82c9784d483d09540f&key=6931539c47d7ce8c28388914f70aaede29933f2f8a0aa5bec0a81d644dc182a6986ba2f38bf55948e558159d8a0256ebbc26f4c162f080d4eb8cf48d31c64e846a2fdce0eba6e6a86b934809f74888a8&ascene=1&uin=MjUwNjI4MjcyMg%3D%3D&devicetype=Windows+7&version=6208006f&lang=zh_CN&exportkey=AVcbxLEMgoQhwYtsGDNBMTw%3D&pass_ticket=BoB6ESLz56pa8XLUtLso9tB5F%2FQXeGWb%2FWCfMIay9HEGc%2BsbNaN4xcnI6Rrorarm)  
1. [aspenONE Suite(流程加工模拟软件) v11.1破解版 附激活教程](https://www.5down.net/soft/aspenone-11.html)
1. [化工加：AspenONE V12安装教程（附视频）](https://www.chemical-plus.cn/13249.html)





![](/img/wc-tail.GIF)
