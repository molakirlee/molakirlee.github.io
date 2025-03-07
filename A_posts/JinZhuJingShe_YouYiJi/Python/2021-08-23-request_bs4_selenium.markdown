---
layout:     post
title:      "python selenium+chromedriver安装及爬虫算例"
subtitle:   ""
date:       2021-08-24 23:29:00
author:     "XiLock"
header-img: "img/post-background/bamboo3.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Python
    - 2021


---

### 要看的一些资料
1. [Python爬虫学习](https://thelnktears.github.io/2020/03/13/Python%E7%88%AC%E8%99%AB%E5%AD%A6%E4%B9%A0/)
1. [爬虫系列6 详解爬虫中BeautifulSoup4的用法](https://segmentfault.com/a/1190000039030926)


### Requests+BS4爬sci-hub

###### 示例
xilock写了个示例，参见[这里](https://github.com/molakirlee/sci-hub_spider)

Erfec写了一个[中国知网爬虫（CNKI） 批量下载PDF格式的论文](https://blog.csdn.net/weixin_45352617/article/details/104281295)，实现了PDF下载功能，但Xilock因为校外VPN访问cnki不稳定，就没测试，可以看一下。

###### 参考资料 
1. [requests 与 beautiful soup基础入门](https://www.jianshu.com/p/9c266216957b)
1. [利用doi号批量下载文章（BeautifulSoup4、Sci-Hub、Scraper）](https://www.mengshuo.xyz/2022/02/10/other/sci_scraper/#%E6%A0%B9%E6%8D%AEDOI%E5%8F%B7%E6%89%B9%E9%87%8F%E4%B8%8B%E8%BD%BD%E6%96%87%E7%8C%AE)
1. [python beautiful soup库的超详细用法](https://www.cnblogs.com/111testing/p/10323159.html)


### Selenium+Chromedriver爬知网
###### 安装

**安装selenium**

```
pip install selenium
```
但pip有时候出幺蛾子，不行的话就用conda装：
```
conda install selenium
```

**安装chromedriver**

chromedriver的版本一定要与Chrome的版本一致，不然就不起作用（如“92.0.4515.107_chrome32_stable_windows_installer.exe”匹配“chromedriver_win32_92.0.4515.107”,[下载地址及提取码: ktwj](https://pan.baidu.com/s/1QraUPswlRRUrPzLIEtinzQ)）。  
1. 有两个下载地址：1、 [http://chromedriver.storage.googleapis.com/index.html](http://chromedriver.storage.googleapis.com/index.html)；2、 [https://npm.taobao.org/mirrors/chromedriver/](https://npm.taobao.org/mirrors/chromedriver/)
1. 下载完后解压，找到chromedriver.exe复制到chrome的安装目录（C:\Program Files (x86)\Google\Chrome\Application\），将文件位置（C:\Program Files (x86)\Google\Chrome\Application\）添加到环境变量PATH里
1. 在cmd里输入`chromedriver`检查是否安装成功，或者输入下面代码看是否自动弹出一个浏览器：

```
from selenium import webdriver
import time

def main():
    b = webdriver.Chrome()
    b.get('https://www.baidu.com')
    time.sleep(5)
    b.quit()

if __name__ == '__main__':
    main()
```

但是会有一个没有什么影响的警告
```
[27280:10064:0513/222542.826:ERROR:device_event_log_impl.cc(214)] [22:25:42.825] Bluetooth: bluetooth_adapter_winrt.cc:1204 Getting Radio failed. Chrome will be unable to change the power state by itself.
[27280:10064:0513/222542.847:ERROR:device_event_log_impl.cc(214)] [22:25:42.847] Bluetooth: bluetooth_adapter_winrt.cc:1282 OnPoweredRadioAdded(), Number of Powered Radios: 1
[27280:10064:0513/222542.848:ERROR:device_event_log_impl.cc(214)] [22:25:42.848] Bluetooth: bluetooth_adapter_winrt.cc:1297 OnPoweredRadiosEnumerated(), Number of Powered Radios: 1
```

这主要是因为`These errors are the direct impact of the changes incorporated with google-chrome`，解决方法参见[这里](https://stackoverflow.com/questions/61325672/browser-switcher-service-cc238-xxx-init-error-with-python-selenium-script-w)

原理点在这里[Selenium Chrome Driver: Resolve Error Messages Regarding Registry Keys and Experimental Options](http://blogs.stevelongchen.com/2020/05/15/selenium-chrome-driver-resolve-error-messages-regarding-registry-keys-and-experimental-options/)

即：添加一个`excludeSwitches: ['enable-logging']`

因为不影响使用，所以可以直接忽略它，也可以去更新一下啥的（Xilock没试过），处于强迫症，Xilock决定Suppressing the error，所以就有了这段代码：
```
from selenium import webdriver
import time
from selenium.webdriver.chrome.options import Options

def main():
    options = webdriver.ChromeOptions()
    options.add_experimental_option('excludeSwitches', ['enable-logging'])
    b = webdriver.Chrome(options=options, executable_path=r'C:\Users\Xilock\AppData\Local\Google\Chrome\Application\chromedriver.exe') 
    
    b.get('https://www.baidu.com')
    time.sleep(5)
    b.quit()

if __name__ == '__main__':
    main()
```

###### 爬虫知网算例
写了几个爬知网文献的[case](https://github.com/molakirlee/python_selenium)，但是XPATH变得比较频繁，用的话可能需要经常自己手动更新。顺便录了一个[使用selenium爬知网实例](https://www.bilibili.com/video/BV1U44y1k7Yq/)。

注：xpath可用edge的插件“SelectorsHub - XPath Plugin”或“Xpath finder”获取。


代码爱小菜鸡写了个[《用Python自动化爬取CNKI知网数据（批量下载PDF论文）》](https://blog.csdn.net/weixin_45678463/article/details/111826523)，但Xilock这边校外ip不方便


###### 要练习的爬虫算例
1. requests+正则表达式爬取静态网页（最好是加入搜索关键词的），并加入多进程，数据库存储，文件下载（图片和文本）
2. requests+lxml+xpath爬取静态网页，其他同第（1）点
3. requests+bs4+css/xpath爬取静态网页，其他同第（1）点
4. requests+pyquery+css爬取静态网页，其他同第（1）点
5. selenium+Phantomjs爬取静态网页，其他同第（1）点
6. pyspider+ selenium+Phantomjs爬取静态网页，其他同第（1）点（静态网页用pyspider爬感觉大材小用）
7. scrapy爬取动态网页，其他同第（1）点
8. 找一个封IP和cookies的网站（比如微博），用scrapy爬取，把几个pipeline都用起来，然后加入分布式爬取（找3个云服务器就ok了，一个发布任务，两个爬取），其他同第（1）点

###### 参考资料
1. [selenium 安装与 chromedriver安装](https://www.cnblogs.com/lfri/p/10542797.html)
1. [Python爬虫，批量获取知网文献信息](http://events.jianshu.io/p/56722a33ad07)
1. [Some bioinformatics tool scripts](https://github.com/byemaxx/BioTools)

### 爬文件
写了一个基于python的小爬虫，可以处理双层网站（即目录--点击跳转--点击下载），放[github](https://github.com/molakirlee/crawler_request)里了.

参考资料：
1. [Python爬虫批量下载PDF文档](https://blog.csdn.net/qq_41101239/article/details/118094007?ops_request_misc=%257B%2522request%255Fid%2522%253A%2522165251933916781483765713%2522%252C%2522scm%2522%253A%252220140713.130102334.pc%255Fall.%2522%257D&request_id=165251933916781483765713&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~first_rank_ecpm_v1~rank_v31_ecpm-4-118094007-null-null.142^v9^pc_search_result_cache,157^v4^control&utm_term=python%E6%89%B9%E9%87%8F%E4%B8%8B%E8%BD%BDpdf%E6%96%87%E4%BB%B6)
1. [python爬虫下载恩智浦智能车竞赛技术报告](https://thelnktears.github.io/2020/04/01/python%E7%88%AC%E8%99%AB%E4%B8%8B%E8%BD%BD%E6%81%A9%E6%99%BA%E6%B5%A6%E6%99%BA%E8%83%BD%E8%BD%A6%E7%AB%9E%E8%B5%9B%E6%8A%80%E6%9C%AF%E6%8A%A5%E5%91%8A/)


![](/img/wc-tail.GIF)
