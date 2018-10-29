 “Here We Go. ”


# 前言

XiLock 的 Blog 就这么开通了。

[跳过扯皮，看看XiLock怎么搭的Blog ](#build) 



2018 年，XiLock 开通了自己的微信公众号“神探玺洛克”。感觉总算有个地方可以好好写点东西了。


起初只是写了点东西想找个地方贴一贴。后来在朋友的推荐之下，又创了个[“知乎专栏”](https://zhuanlan.zhihu.com/c_216544369)，而为了保证专栏的开通随便拉了个IP“西游记”。


刚开始XiLock觉得这两个地方发文章就够了，但后来发现，推送了几篇有言论的文章之后微信公众号对我的审核开始加强，不仅仅是禁止文章的发布，甚至是把我的草稿都给删除了，要知道，我发的文章可都是积极向上正能量的。


所以，XiLock决定开始做博客了。嗯，就是这么简单。


作为一个追求自由释放的厨子，最不喜欢把什么东西整的束手束脚，而大众博客又恰恰是这样，一是觉得大部分 Blog 服务都太丑，二是觉得不能随便定制不好玩。将 Blog 这种轮子挂在大众博客程序上就太没意思了。


之前因为太懒没有折腾，结果就一直连个写 Blog 的地儿都没有，一不做二不休，花一天搞一个吧！


XiLock开始开疆拓土!


<p id = "build"></p>
---

# Blog搭建


之前就有关注过 [GitHub Pages](https://pages.github.com/) + [Jekyll](http://jekyllrb.com/) 快速 Building Blog 的技术方案，非常轻松时尚。

优点非常明显：

* Markdown** 带来的优雅写作体验
* 非常熟悉的 Git workflow ，**Git Commit 即 Blog Post**
* 利用 GitHub Pages 的域名和免费无限空间，不用自己折腾主机
* 如果需要自定义域名，也只需要简单改改 DNS 加个 CNAME 就好了 
* Jekyll 的自定制非常容易，基本就是个模版引擎


---

配置的过程相当顺手，基本就是 Git 的流程。

Jekyll 主题上直接 fork 了 黄导的 Blog

简单说下jekyll安装的过程

- 下载[Ruby+Devkit](https://rubyinstaller.org/downloads/)并安装，**安装过程中记得勾选添加环境变量**。完成后通过`ruby -v`检查是否安装成功。
- `gem -v`检查gem是否安装成功。
- `gem install jekyll`安装jekyll。（若提示“don't have jekyll-paginate or one of its dependencies installed”，则可能是因为没有安装jekyll-paginate。用`gem list`查看下“LOCAL GEMS”，若没有jekyll-paginate则通过`gem install jekyll-paginate`安装）

jekyll本地动态监视网站的命令为`jekyll s --watch`

*PS:本地调试环境需要 `gem install jekyll`，结果 rubygem 的源居然被墙了……后来从网上查了下改成淘宝的镜像源才成功。*

theme 的 CSS 是基于 Bootstrap 定制的，看得不爽的地方直接在 Less 里改就好。

Jekyll的文件结构可以参考 [掘金](https://juejin.im/post/5b235a1cf265da597568a97d) 和 [Comtu](http://comtu.github.io/2014/10/19/Jekyll_Variables.html) 的介绍。

之后就进入了耗时反而最长的**做图、写字**阶段，也算是进入了**写博客**的正轨，因为是类似 Hack Day 的方式去搭这个站的，所以折腾折腾着大半夜就过去了。

添加文章二维码可参考[这个插件](http://jeromeetienne.github.io/jquery-qrcode/)，左上角链接可直达Github，里面有demo。

添加网站统计可以用[“不蒜子”](http://ibruce.info/2015/04/04/busuanzi/)

添加Google Analyze可参见 [这个方法](https://desiredpersona.com/google-analytics-jekyll/)

之后又考虑中文字体的渲染，fork 了 [Type is Beautiful](http://www.typeisbeautiful.com/) 的 `font` CSS，调整了字号，适配了 Win 的渣渲染，中英文混排效果好多了。

这个[总结](https://www.ezlippi.com/blog/2015/03/github-pages-blog.html)感觉比较全面

# 后记

回顾这个博客的诞生，纯粹是出于个人兴趣，也终究只是个人兴趣。

既然生命不长，到了这里，希望你喜欢这里的文章。

— XiLock 后记于 2018.10.26