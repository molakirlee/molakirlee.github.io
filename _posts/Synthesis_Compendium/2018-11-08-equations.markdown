---
layout:     post
title:      "Pool:常用公式总结"
subtitle:   "发现自己总忘，就整理了一下贴在这里了"
date:       2018-11-08 10:38:00
author:     "XiLock"
header-img: "img/in-post/2018/2018-11-08-equqtions/bg.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 整理汇总
    - 2018


---


#### 化工
###### 热力学基本方程

$$dU = \delta Q + \delta W $$

1. 可逆：$ \delta Q = TdS $；
2. 只做体积功：$\delta W = -pdV$；
3. **热力学基本方程的适用条件：**于封闭的热力学平衡系统所进行的一切可逆过程。

**超级公式：**

$$
\begin{vmatrix}
&H&\\
PV&|U\\
PV&|A|&TS\\
&G|&TS
\end{vmatrix}
$$

$$
\require{cancel}
\begin{matrix}
T&A&V\\
G&\cancelto{}{\nwarrow}&U\\
P&H&S
\end{matrix}
$$

1. 靠近自己的是**Var**；
2. Maxwell **先横再竖** 时$\partial$前有**负号**；
3. 角标在箭头上时$\partial$前有**负号**；
![](/img/in-post/2018/2018-11-08-equqtions/maxwell.JPG)

#### 数学
###### 泰勒定理
设n是一个正整数，如果定义在一个包含a的区间上的函数f在a处n+1次可导，那么对于这个区间上任意x都有：

$$
f(x) = f(a) + \frac{f'(a)}{1!}(x-a) + \frac{f^{(2)}(a)}{2!}(x-a)^2 + \dots + \frac{f^{(n)}(a)}{n!}(x-a)^n + R_n(x)
$$

其中的多项式称为函数在a处的泰勒展开式，余项$R_n(x)$为$(x-a)^n$的高阶无穷小。

参考阅读：  
[Wiki-泰勒公式](https://zh.wikipedia.org/wiki/%E6%B3%B0%E5%8B%92%E5%85%AC%E5%BC%8F)

###### 微积分
1. [金玉明_实用积分表_中科大出版社](https://github.com/molakirlee/Blog_Attachment_A/blob/main/!collect/金玉明_实用积分表_中科大出版社.pdf)

#### 化学
###### 原子轨道
![](/img/in-post/整理汇总/2018-11-08-equations/spdfg_MO.png)
###### 给电子集团EDG/拉电子集团EWG
![](/img/in-post/整理汇总/2018-11-08-equations/EDG_EWG.png)


![](/img/wc-tail.GIF)
