---
layout:     post
title:      "redhat6.7安装yum和python3及与python2切换"
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

### python3与python2的切换
安装完两个版本的python后（python2.7安装见参考资料5）用`alternatives`可以实现python版本的切换。  

###### 安装python
###### 挂钩
```
# alternatives --install /usr/bin/python python /usr/bin/python2.7 1
# alternatives --install /usr/bin/python python /usr/bin/python3.6 2
# mv /usr/bin/pip /usr/bin/pip.bak    //原有的pip不是软连接，先把它干掉
# alternatives --install /usr/bin/pip pip /usr/bin/pip2.7 1
# alternatives --install /usr/bin/pip pip /usr/local/bin/pip3.6 2
```
###### 检查是否生效
```
# alternatives --display python
python - status is auto.
 link currently points to /usr/bin/python3.6
/usr/bin/python2.7 - priority 1
/usr/bin/python3.6 - priority 2
Current `best' version is /usr/bin/python3.6.
```
###### 切换Python和pip版本

```
# alternatives --config python
 
There are 2 programs which provide 'python'.
 
  Selection    Command
-----------------------------------------------
   1           /usr/bin/python2.7
*+ 2           /usr/bin/python3.6
 
Enter to keep the current selection[+], or type selection number:
 
# alternatives --config pip
```
输入对应版本的序号就可以完成一键切换了。

**若`yum`不能使用，报`SyntaxError: invalid syntax`错，解决见参考资料6.**

### 参考资料：
1. [可靠参考：redhat6.7的yum配置](https://blog.csdn.net/LostSpeed/article/details/79706766)
2. [RedHat安装Python3.6版本](https://blog.csdn.net/weixin_40283570/article/details/81630111)
3. [python环境配置（二）——centos6+ 安装python3.6以及pip3](https://blog.csdn.net/weixin_42350212/article/details/83008248)
4. [解决更新升级python和pip版本后，不生效的问题](https://blog.csdn.net/DBC_121/article/details/105458361)
5. [How to Install Python 2.7.18 on CentOS/RHEL 7/6 and Fedora 32/31](https://tecadmin.net/install-python-2-7-on-centos-rhel/)
6. [CentOS 7中实现Python 3.6与2.7共存及版本切换](https://blog.csdn.net/lpwmm/article/details/80160242)

![](/img/wc-tail.GIF)
