 “Here We Go. ”


### 前言

XiLock 的 Blog 就这么开通了。

[跳过扯皮，看看XiLock怎么搭的Blog ](#build) 



2018 年，XiLock 开通了自己的微信公众号“神探玺洛克”。感觉总算有个地方可以好好写点东西了。


起初只是写了点东西想找个地方贴一贴。后来在朋友的推荐之下，又创了个[“知乎专栏”](https://zhuanlan.zhihu.com/c_216544369)，而为了保证专栏的开通随便拉了个IP“西游记”。


刚开始XiLock觉得这两个地方发文章就够了，但后来发现，推送了几篇有言论的文章之后微信公众号对我的审核开始加强，不仅仅是禁止文章的发布，甚至是把草稿都给删除了……这里的文章可都是积极向上正能量的。


所以，XiLock决定开始做博客了。嗯，就是这么简单。


作为一个不喜欢被束手束脚的厨子，不喜欢条条框框的大众博客，一是觉得大部分 Blog 服务都太丑，二是觉得不能随便定制不好玩。将 Blog 这种轮子挂在大众博客程序上就太没意思了。


之前因为太懒没有折腾，结果就一直连个写 Blog 的地儿都没有，一不做二不休，花一天搞一个吧！


XiLock开始开疆拓土!


<p id = "build"></p>
---

### Blog搭建


之前就有关注过 [GitHub Pages](https://pages.github.com/) + [Jekyll](http://jekyllrb.com/) 快速 Building Blog 的技术方案，非常轻松时尚。

优点非常明显：

* **Markdown** 带来的优雅写作体验
* 非常熟悉的 Git workflow ，**Git Commit 即 Blog Post**
* 利用 GitHub Pages 的域名和免费无限空间，不用自己折腾主机
* 如果需要自定义域名，也只需要简单改改 DNS 加个 CNAME 就好了 
* Jekyll 的自定制非常容易，基本就是个模版引擎


---

配置的过程相当顺手，基本就是 Git 的流程。

#### Jekyll安装
简单说下jekyll安装的过程

- 下载[Ruby+Devkit](https://rubyinstaller.org/downloads/)并安装，**安装过程中记得勾选添加环境变量**。完成后通过`ruby -v`检查是否安装成功。
- `gem -v`检查gem是否安装成功。
- `gem install jekyll`安装jekyll。（若提示“don't have jekyll-paginate or one of its dependencies installed”，则可能是因为没有安装jekyll-paginate。用`gem list`查看下“LOCAL GEMS”，若没有jekyll-paginate则通过`gem install jekyll-paginate`安装）

jekyll本地动态监视网站的命令为`jekyll s --watch`

*PS:本地调试环境需要 `gem install jekyll`，结果 rubygem 的源居然被墙了……后来从网上查了下改成淘宝的镜像源才成功。*

#### Jekyll主题
Jekyll 主题上直接 fork 了 黄导的 Blog

theme 的 CSS 是基于 Bootstrap 定制的，看得不爽的地方直接在 Less 里改就好。

Jekyll的文件结构可以参考 [掘金](https://juejin.im/post/5b235a1cf265da597568a97d) 和 [Comtu](http://comtu.github.io/2014/10/19/Jekyll_Variables.html) 的介绍。

#### 撰文
之后就进入了耗时反而最长的**做图、写字**阶段，也算是进入了**写博客**的正轨，因为是类似 Hack Day 的方式去搭这个站的，所以折腾折腾着大半夜就过去了。

#### SSH配置
使用Secure Shell (SSH)协议可以更方便的登录到SSH服务器，而无需输入密码。因为无需发送你的密码到网络中，SSH 密钥对被认为是更加安全的方式。

1.首先需要检查你电脑是否已经有 SSH key 
运行 git Bash 客户端，输入如下代码：
```
$ cd ~/.ssh
$ ls
```
这两个命令就是检查是否已经存在 id_rsa.pub 或 id_dsa.pub 文件，如果文件已经存在，那么你可以跳过步骤2，直接进入步骤3。

2.创建一个 SSH key
```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

注：
-t 指定密钥类型，默认是 rsa，可以省略。
-C 设置注释文字，比如邮箱。
-f 指定密钥文件存储文件名。
```
这将会使用你提供的email作为标签，创建一个新的SSH Key
```
Generating public/private rsa key pair.
\# Enter file in which to save the key (/c/Users/you/.ssh/id_rsa): [Press enter]
```
当然，你也可以不输入文件名，使用默认文件名（推荐），那么就会生成 id_rsa 和 id_rsa.pub 两个秘钥文件。
接着又会提示你输入两次密码（该密码是你push文件的时候要输入的密码，而不是github管理者的密码），
当然，你也可以不输入密码，直接按回车。那么push的时候就不需要输入密码，直接提交到github上了，如：
```
Enter passphrase (empty for no passphrase): 
\# Enter same passphrase again:
```
接下来，就会显示如下代码提示，如：
```
Your identification has been saved in /c/Users/you/.ssh/id_rsa.
\# Your public key has been saved in /c/Users/you/.ssh/id_rsa.pub.
\# The key fingerprint is:
\# 01:0f:f4:3b:ca:85:d6:17:a1:7d:f0:68:9d:f0:a2:db your_email@example.com
```
当你看到上面这段代码的收，那就说明，你的 SSH key 已经创建成功，你只需要添加到github的SSH key上就可以了。

3.添加你的 SSH key 到 github上面去

3.1 首先你需要拷贝 id_rsa.pub 文件的内容，你可以用编辑器打开文件复制，也可以用git命令复制该文件的内容，如：
```
$ clip < ~/.ssh/id_rsa.pub
```
3.2 登录你的github账号，从又上角的设置（ Account Settings ）进入，然后点击菜单栏的 SSH key 进入页面添加 SSH key。

3.3 点击 Add SSH key 按钮添加一个 SSH key 。把你复制的 SSH key 代码粘贴到 key 所对应的输入框中，记得 SSH key 代码的前后不要留有空格或者回车。当然，上面的 Title 所对应的输入框你也可以输入一个该 SSH key 显示在 github 上的一个别名。默认的会使用你的邮件名称。

4.测试一下该SSH key
在git Bash 中输入以下代码
```
$ ssh -T git@github.com
```
当你输入以上代码时，会有一段警告代码，如：
```
The authenticity of host 'github.com (207.97.227.239)' can't be established.
\# RSA key fingerprint is 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48.
\# Are you sure you want to continue connecting (yes/no)?
```
这是正常的，你输入 yes 回车既可。如果你创建 SSH key 的时候设置了密码，接下来就会提示你输入密码，如：
```
Enter passphrase for key '/c/Users/Administrator/.ssh/id_rsa':
```
当然如果你密码输错了，会再要求你输入，知道对了为止。

注意：输入密码时如果输错一个字就会不正确，使用删除键是无法更正的。

密码正确后你会看到下面这段话，如：
```
Hi username! You've successfully authenticated, but GitHub does not provide shell access.
```
如果用户名是正确的,你已经成功设置SSH密钥。如果你看到 “access denied” ，这表示拒绝访问，那么你就需要使用 https 去访问，而不是 SSH 。

5.修改.git文件夹下config中的url。
修改前
```
[remote "origin"]
url = https://github.com/molakirlee/molakirlee.github.io
fetch = +refs/heads/*:refs/remotes/origin/*
```
修改后
```
[remote "origin"]
url = git@github.com:molakirlee/molakirlee.github.io
fetch = +refs/heads/*:refs/remotes/origin/*
```

*设置SSH参考Github官网关于[SSH的教程](https://help.github.com/articles/connecting-to-github-with-ssh/)*

#### 添加文章二维码
添加文章二维码可参考[这个插件](http://jeromeetienne.github.io/jquery-qrcode/)，左上角链接可直达Github，里面有demo。

添加二维码后，手机扫码可直接进入手机版。

#### 添加网站统计
添加网站统计可以用[“不蒜子”](http://ibruce.info/2015/04/04/busuanzi/)

添加Google Analyze可参见 [这个方法](https://desiredpersona.com/google-analytics-jekyll/)

#### 字体渲染
之后又考虑中文字体的渲染，fork 了 [Type is Beautiful](http://www.typeisbeautiful.com/) 的 `font` CSS，调整了字号，适配了 Win 的渣渲染，中英文混排效果好多了。

#### 自定义域名
###### 无SSL证书（HTTP）
自定义域名包括以下几步：
1. 注册域名，可使用[Freenom](https://my.freenom.com/)申请免费域名，但注意及时更新。
2. 在github的根目录下创建文本文件“CNAME”，内容为域名地址，如“chefxilock.cf”
3. 在Freenom里配置DNS，"My Domains" --> "Manage Domain" --> "Manage Freenom DNS" --> 添加1个CNAME记录（github.io域名）和1个A记录（ping你的github.io域名后得到的IP）
4. 保存后等待生效。

注：
1. Freenom用新的谷歌帐号登陆时，可能会提示“Your social login could not be deturemined”，无法确定您的社交登录名。这时先不登陆，先搜索一个带后缀的域名（如chefxilock.cf，切记腰带后缀cf）。然后提交订单的时候，左下角会有一个“Verify My Email Address”，然后输入邮箱帐号登陆，并在收到的邮件中填写信息（信息用“u.s. fake address”生成，直接google搜索就能找到很多生成“u.s. fake address”的网站），然后继续完成下单，则可顺利拿下域名。
1. Freenom下单后提示“Some of your domains could not be registered because of a technical error. These domains have been cancelled”，则用“u.s. fake address”重新生成信息并填写一下，则可解决。
1. google帐号要经常登陆，要不就会因为不识别身份而登陆不上。

参考资料：[github怎么绑定自己的域名](https://www.zhihu.com/question/31377141)

###### SSL证书设置（HTTPS）
在上述HTTP基础上，可通过SSL证书设置增加安全性，变成HTTPS。有多种方式，这里列举Xilock测试过的两种：  
第一种是xilock最开始用的，为了打开HTTPS的安全访问，玺洛克用[CloudFlare](https://dash.cloudflare.com)设定了DNS加速和SSL证书。
1. 打开CloudFlare之后，根据指引点击Add Site，添加自定义域名（如chefxilock.cf），会自动开始扫描DNS解析记录。
2. 扫描完成后，Cloudflare会选择给我们分配两个NS地址，将这两个地址添加到"My Domains" --> "Manage Domain" --> "Management Tools" --> "Nameservers"里的Nameserver1和Nameserver2
3. 记得在CloudFlare的SSL里打开**Always Use HTTPS**，但不要选Full，选Flexible，否则连接时可能出现“使用了不受支持的协议”。

参考资料：
1. [yucicheung](https://blog.csdn.net/yucicheung/article/details/79560027)
1. [xietao3](https://www.jianshu.com/p/eb1bcc3da8d6)的博客
1. [解决 Cloudflare 代理 HTTPS 出错](https://ews.ink/tech/network-cloudflare-ssl/)

第二种使用[DNSPOD](https://console.dnspod.cn/dns/list)
1. DNS解析 --> 我的域名 --> 添加域名chefxilock.cf。
2. 添加2个CNAME记录（@ github.io域名和www github.io域名）。
3. 在freenom里添加两个Namerserver：phecda.dnspod.net和hospital.dnspod.net
4. 在SSL里申请签发。
5. SSL签发下来以后，登陆网页可能还是没有https和小绿锁，此时去github的相应项目里找Settings，然后在Pages里找到“Custom domain --> Enforece HTTPS”，此时可能显示“Unavailable for your site because your domain is not properly configured to support HTTPS (chefxilock.cf) — Troubleshooting custom domains ”，且上方为棕色的“DNS Check in Progress”。将chefxilock.cf改为www.chefxilock.cf后保存（建议直接在CNAME文件里改，要不还得重新pull），此时变为绿色对勾的“DNS check successful”，然后下方的“Enforce HTTPS”也可勾选了，勾选上再测试下，网站应该就是HTTPS的了。

#### 添加搜索框
使用[这个包](https://github.com/androiddevelop/jekyll-search)可以对文章标题、时间、标签进行搜索。

#### 其他参考
这个[总结](https://www.ezlippi.com/blog/2015/03/github-pages-blog.html)感觉比较全面。

### 后记

回顾这个博客的诞生，纯粹是出于个人兴趣，也终究只是个人兴趣。

既然生命不长，到了这里，希望你喜欢这里的文章。

— XiLock 后记于 2018.10.26

### 更新20181108
**在博文中添加公式**  
将以下代码添加到<head>里面
```html
<!--在博文中使用公式 START-->
<script type="text/javascript" async src="//cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML">
</script>
<!--添加分隔符"$...$"-->
<script type="text/x-mathjax-config">
  MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}});
</script>
<!--在博文中使用公式 END-->
```
更新于2018.11.08

### 更新20181121
今天发现有的博文Disqus加载不出来，但有的能加载出来。以为是post格式有问题，改了内容和文件名均无效。后来把`disqus_url`这个变量注释掉发现可以了，iissnan说“有`disqus_identifier`就可以。至于页面的链接，Disqus 会自动取 window.location.href，对于生成静态页面的情况这个值也是正确的”（[参考](https://github.com/iissnan/hexo-theme-next/issues/876)）。也有人说url里面不应该加“http”，但没测试（[参考](https://github.com/iissnan/theme-next-docs/issues/86)）。
更新于2018.11.21

### 更新20181122
本来就是想添加一个欢迎页面，结果试了好几个模板才找到合适的。  
处理了欢迎页的问题，紧接着便是：更换index之后（将欢迎页改为index，将原来的index改为home），博文竟然显示不出来了。几番检查才发现原来是因为非index页不能实现博文的分页显示（采用分页显示时则直接空白）。本想稍微花点时间处理一下，结果折腾了一个上午和一个晚上，下面总结一下。  
如果博文太多了怎么办？通过paginate可以实现博文的分页，参考：[官方教程](https://jekyllcn.com/docs/pagination/)  
但分页功能是有条件的：  
1. Jekyll 的分页功能不支持 Jekyll site 中的 Markdown 或 Textile 文件。
1. 分页功能从名为 index.html 的 HTML 文件中被调用时，才能工作。

那么是不是只有index.html文件才能添加分页呢？是的，但别灰心，虽然只有index.html文件可以添加分页，但是我们可以有多个index.html文件，即创建子文件夹。详情参考：[如何给多个页面添加分页](https://stackoverflow.com/questions/21248607/jekyll-pagination-on-every-page)  
简单概括一下：创建子文件夹blog，在子文件夹blog中创建希望实现博文分页显示的index.html文件。  
**注意：**链接到index.html时一定要写index.html而不能只写index，否则访问不到。

为了让欢迎页壁纸好看，玺洛克采用了bing的壁纸，图片源如下:  
```front_img_path: "http://area.sinaapp.com/bingImg/" #自动采用bing的壁纸```

顺便说一下导航栏标签的问题：  
本站的标签在导航栏里，是采用的液体代码的方式调用的。想更改导航栏顺序可参考：[如何更改导航栏标签顺序](https://codeday.me/bug/20171216/108952.html)

关于这些操作里面的变量，可参考：[jekyll变量说明](https://jekyllcn.com/docs/variables/)

对于Tags中的标签进行了排序和添加色彩。  
添加色彩：  
```
<a href="#{{ tag[0] }}" title="{{ tag[0] }}" rel="{{ tag[1].size }}">{{ tag[0] }}</a>
```

排序：  
{%raw%}
```
{% capture tags %}
  {% for tag in site.tags %}
    {{ tag | downcase | replace:' ','-' }}
  {% endfor %}
{% endcapture %}
{% assign sorted_post_tags = tags | split:' ' | sort %}
{% for sorted_tag in sorted_post_tags %}
  {% for tag in site.tags %}
    {% assign downcase_tag = tag | downcase | replace:' ','-' %}
    {% if downcase_tag == sorted_tag %}
      <a href="{{ page.url }}#{{ tag[0] }}">{{ tag[0] }}</a>
    {% endif %}
  {% endfor %}
{% endfor %}
```
{%endraw%}


如果想要又排序又添加色彩，则用
```
<a href="#{{ tag[0] }}" title="{{ tag[0] }}" rel="{{ tag[1].size }}">{{ tag[0] }}</a>
```
替换  
```
<a href="{{ page.url }}#{{ tag[0] }}">{{ tag[0] }}</a>
```

### 更新20181208
今天发现20181122更新的代码排序没有正常在本文里显示，主要是因为块标题
{%raw%}
```
{% %}
```
{%endraw%}
把&apos;&apos;&apos;  &apos;&apos;&apos;的先后分别添加
`
{\%raw%}
`
和
`
{\%endraw%}
`即可。

### 更新20190628
另一篇参考：[Using Hugo, GitLab Pages, and Cloudflare to create and run this Website](https://tkainrad.dev/posts/using-hugo-gitlab-pages-and-cloudflare-to-create-and-run-this-website/)

### 更新20201005
发现home界面的tags连接不上，但菜单栏里的tags里面的可以连接上。检查了下发现是之前把所有的博文md放进post这个文件夹后，`_layouts`里面的格式没有及时修改，将如下部分做对应修改即可：原来是：`{{ site.baseurl }}/tags/#{{ tag[0] }}`；现在是：`{{ site.baseurl }}/blog/tags/#{{ tag[0] }}`）。

### 更新20210124
###### 添加导航条Research，调整导航条顺序
加了个导航条“Research”，然后调整了导航条的顺序。解决导航条顺序的方法为：在文件名称前添加“01_”控制文件的排序，从而控制导航条在pages中的排序。（参考资料：[jekyll进阶](https://blog.csdn.net/yy228313/article/details/51071934)）
###### 修正Research和About中disqus不显示的问题
将02_about.html中的下列代码保留（用于显示评论框）：
```
{% if site.disqus_username %}
<!-- disqus 评论框 start -->
<div class="comment">
    <div id="disqus_thread" class="disqus-thread"></div>
</div>
<!-- disqus 评论框 end -->
{% endif %}
```

将02_about.html中的下列代码移动到page.html末尾（disqus的配置，因为research.html和about.html均是以page.html为模板，所以在page.html统一配置即可）：
```
{% if site.disqus_username %}
<!-- disqus 公共JS代码 start (一个网页只需插入一次) -->
<script type="text/javascript">
    /* * * CONFIGURATION VARIABLES * * */
    var disqus_shortname = "{{site.disqus_username}}";
    var disqus_identifier = "{{site.disqus_username}}/{{page.url}}";
    var disqus_url = "{{site.url}}{{page.url}}";

    (function() {
        var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
        dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
    })();
</script>
<!-- disqus 公共JS代码 end -->
{% endif %}
```
但发现仍然加载不出disqus来，所以将配置部分代码修改如下：
```
{% if site.disqus_username %}
<!-- disqus 公共JS代码 start (一个网页只需插入一次) -->
<script type="text/javascript">
    /* * * CONFIGURATION VARIABLES * * */
    var disqus_shortname = "{{site.disqus_username}}";
    var disqus_identifier = "{{page.id}}";
    <!--var disqus_url = "{{site.url}}{{page.url}}";-->

    (function() {
        var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
        dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
    })();
</script>
<!-- disqus 公共JS代码 end -->
{% endif %}
```
这次就可以了！

**注意：Disqus有时会因为连接问题而直接不显示（别问我为什么，我也不知道为啥有时候有而有时候连个P都刷不出来，大概是因为连接的稳定性问题），同时看看post里、其它标签里有没有，如果都“直接啥也没有”，那就等一段时间刷新再看看；如果是提示load不出来，那可能是代码调用的问题。**

### 更新20210301
使用[Link Lock](https://github.com/jstrieb/link-lock)可以为登录设置密码。会生成一个新的地址，登录后需要密码才能进入。但是该方法不能修改密码，而且一单密码忘了也就只能破解。

### 更新20210522
使用osmos::feed可以实现RSS订阅，具体参见github。
1. [osmos::feed 利用GitHub搭建个人RSS阅读器](https://github.com/osmoscraft/osmosfeed/blob/master/README_zh.md)  

注意：
1. 订阅地址务必有效，否则整个脚本都不能运行。
1. 出问题时去action里自行查看问题出在哪。


### 更新20210723
添加侧边栏时，需同时修改“_config.yml”文件和“_layouts\page.html”文件里的相关内容。

### 更新20210804
1. 收到github通知说repositories最大储存容量500M，看了下已经300M+了，非长久之计，打算清理下.git文件夹，结果按照[这篇文章](https://blog.csdn.net/cysear/article/details/102823671)的指示操作，最后把所有的rar文件都抹掉了，连checkout退回的版本里也没有rar记录了，后来发现500M流量是针对private的，public还是free……做处理之前一定要先备份好啊！
2. 发现，在attachment文件夹里放一个内容为"Blog_Attachment_A"的README.md文件的话，会出现一个名为Blog_Attachment_A的Tag……

### 更新20210816
今天`git push`时遇到问题：
```
remote: Support for password authentication was removed on August 13, 2021. Please use a personal access token instead.
remote: Please see https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/ for more information.
``` 
呃，不支持密码验证了，解决方案如下：
1. 在Setting里生成token;
1. 对于Win系统：Go to Credential Manager from Control Panel => Windows Credentials => find git:https://github.com => Edit => On Password replace with with your Github Personal Access Taken => You are Done

参考资料：
1.[GitHub不再支持密码验证解决方案：SSH免密与Token登录配置](https://www.cnblogs.com/zhoulujun/p/15141608.html) 
1.[Support for password authentication was removed. Please use a personal access token instead](https://stackoverflow.com/questions/68775869/support-for-password-authentication-was-removed-please-use-a-personal-access-to) 

### 更新20211017
`git push`时遇到问题：Failed to connect to github.com port 443:connection timed out  
解决步骤1：取消代理
```
git config --global --unset http.proxy
git config --global --unset https.proxy
```

解决步骤2：修改 hosts 文件
添加以下内容到hosts文件（C:\Windows\System32\drivers\etc\HOSTS）
```
# github push
140.82.112.4 github.com 
199.232.69.194 github.global.ssl.fastly.net
185.199.108.153 assets-cdn.github.com
185.199.109.153 assets-cdn.github.com
185.199.110.153 assets-cdn.github.com
185.199.111.153 assets-cdn.github.com
```
然后刷新dns：`ipconfig /flushdns`

地址查询：
1. [github.com ](https://github.com.ipaddress.com/)
1. [github.global.ssl.fastly.net](https://fastly.net.ipaddress.com/github.global.ssl.fastly.net#ipinfo)
1. [assets-cdn.github.com](https://github.com.ipaddress.com/assets-cdn.github.com)

参考资料：
1. [GitHub无法访问、443 Operation timed out的解决办法](https://juejin.cn/post/6844904193170341896)
1. [Failed to connect to github.com port 443 Timed out](https://houbb.github.io/2021/03/06/github-access)

### 更新20220113
1. [静态网站加入评论系统的方法](https://darekkay.com/blog/static-site-comments/)

### 更新20221206
今天`git push`的时候发现又总出现`OpenSSL SSL_connect: Connection was reset in connection to github.com:443`或`Failed to connect to github.com port 443 after 21065 ms: Timed out`，照着“更新20211017”的方法尝试，并参照[OpenSSL SSL_connect: Connection was reset in connection to github.com:443](https://blog.csdn.net/qq_37555071/article/details/114260533)的方法后也不行。灵光一闪，检查下SSH吧，结果去github的Setting里一查SSH key，发现之前的没有了，并不知道原因，但重新生成并添加后就好了。

### 更新20250307
链接到html文件的时候，发现放在`_posts`里的文件上传成功后加载显示404，去掉下划线就好了（即句首下划线会影响网址的链接），所以把`_posts`、`_includes`和`_layouts`都去掉了下划线，结果直接乱码了，后来才意识到下划线不是自己加的而是框架默认的。




