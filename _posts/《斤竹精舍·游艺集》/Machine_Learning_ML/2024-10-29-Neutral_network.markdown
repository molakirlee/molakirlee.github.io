---
layout:     post
title:      "ML 神经网络及其框架"
subtitle:   ""
date:       2024-10-29 09:57:00
author:     "XiLock"
header-img: "img/post-background/bamboo3.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Machine_Learning
    - 2024


---

### 神经网络

神经网络，又称人工神经网络（ANN）或模拟神经网络（SNN），是机器学习的一个分支，也是深度学习算法的核心所在。它们之所以被称为“神经”，是因为它们模拟了大脑中神经元之间的信号传递过程。

神经网络由多个节点层构成，包括输入层、一个或多个隐藏层以及输出层。每个节点都类似于人工神经元，与下一个节点相连，并带有权重和阈值。当某个节点的输出超过阈值时，该节点被激活，将数据传递到网络的下一层。相反，如果低于阈值，数据则不会传递。

1. 前馈神经网络（FFNN, ）：有向无环，信号沿着最终输出的那个方向传播，每一时刻的输入互不影响。如BPNN、DNN、CNN。
1. 循环神经网络（RNN）: ANN隐藏层上添加循环约束变为RNN。可用于时间序列数据、文本数据、音频数据。

对于DNN，激活函数将非线性特性引入网络。这有助于网络学习输入和输出之间的任何复杂关系。但在利用人工神经网络解决图像分类问题时，第一步是在训练模型之前将二维图像转换为一维向量，因此随着图像尺寸的增加，训练参数的数量急剧增加，导致梯度消失和爆炸；且ANN无法在处理序列数据所需的输入数据中捕获序列信息。可用于表格数据、图像数据、文本数据

参考[CNN vs.RNN vs.ANN——浅析深度学习中的三种神经网络](https://cloud.tencent.com/developer/article/1587273?from=article.detail.1590243)


###### 循环神经网络recurrence和递归神经网络Recursion的区别
循环神经网络是线性的，递归神经网络是树状的，当递归神经网络中每个父节点都只有1个子节点时就变成了循环神经网络。

Recursion and recurrence are concepts often used in computer science and mathematics, but they refer to different ideas:

Recursion 

Definition: Recursion is a programming technique where a function calls itself in order to solve a problem. The function typically has a base case to stop the recursion and prevent infinite loops.

Example: A classic example of recursion is the calculation of factorials:
python 
```
  def factorial(n): 
      if n == 0: 
          return 1 
      else: 
          return n * factorial(n - 1) 
```
Recurrence

Definition: Recurrence refers to a way of defining a sequence or a function in terms of its previous values or terms. It is often used in mathematical contexts to express relationships between elements in a sequence.
Example: A common recurrence relation is the Fibonacci sequence:
F(n)=F(n-1)+F(n-2)with base cases F(0)=0 and F(1)=1.
 .
Summary

Recursion is a programming technique that involves self-referential function calls, while recurrence is a mathematical concept that defines sequences based on previous terms. Recursion can be used to implement algorithms that solve recurrences.



### 深度学习框架差异(Tensorflow、Pytorch、Keras和Scikit-learn)
1. Tensorflow更倾向于工业应用领域，适合深度学习和人工智能领域的开发者进行使用，具有强大的移植性。
1. Pytorch更倾向于科研领域，语法相对简便，利用动态图计算，开发周期通常会比Tensorflow短一些。
1. Keras因为是在Tensorflow的基础上再次封装的，所以运行速度肯定是没有Tensorflow快的；但其代码更容易理解，容易上手，用户友好性较强。
1. Scikit-learn(sklearn)的定位是通用机器学习库，而TensorFlow(tf)的定位主要是深度学习库。Scikit-learn适用于中小型、实用机器学习项目，尤其是数据量不大且需要手动对数据进行处理并选择合适模型的项目。

参考资料：
1. [深度学习三大框架之争(Tensorflow、Pytorch和Keras)](https://zhuanlan.zhihu.com/p/364670970)
1. [现在tensorflow和mxnet很火，是否还有必要学习scikit-learn等框架？](https://www.zhihu.com/question/53740695)



![](/img/wc-tail.GIF)
