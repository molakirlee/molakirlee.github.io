---
layout:     post
title:      "redhat6.7安装yum和python3"
subtitle:   ""
date:       2020-08-26 09:27:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Linux
    - 2020

---
 
### yum安装 
redhat6.7下安装yum可参考资料1，rpm的时候提示缺什么再从链接里找来下载rpm上就行。

### python3安装
1. 保留老的Python版本，尽量不要动老版本的东西，用参考资料2的方式安装。
1. 关于参考资料2的连接部分略有差异，可能需要先修改默认连接，即`make install`后用`mv /usr/bin/python /usr/bin/python-2.6.6`修改默认连接，然后用`ln -s /usr/local/python3.6/bin/python3.6  /usr/bin/python`建立新连接（见参考资料3和4）。
1. pip的更新见参考资料4.

### 参考资料：
1. [可靠参考：redhat6.7的yum配置](https://blog.csdn.net/LostSpeed/article/details/79706766)
2. [RedHat安装Python3.6版本](https://blog.csdn.net/weixin_40283570/article/details/81630111)
3. [python环境配置（二）——centos6+ 安装python3.6以及pip3](https://blog.csdn.net/weixin_42350212/article/details/83008248)
4. [解决更新升级python和pip版本后，不生效的问题](https://blog.csdn.net/DBC_121/article/details/105458361)



![](/img/wc-tail.GIF)
