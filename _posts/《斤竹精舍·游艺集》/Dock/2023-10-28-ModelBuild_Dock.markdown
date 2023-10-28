---
layout:     post
title:      "蛋白结构预测+小分子对接"
subtitle:   ""
date:       2023-10-28 18:38:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Dock
    - 2023

---


### 蛋白建模
1. 去[UniProt网站](https://www.uniprot.org)上搜索目标蛋白GALT2的序列，并下载fasta文件。
1. 在[ColabFold](https://github.com/sokrypton/ColabFold)点击"AlphaFold2_mmseq2"链接（Sergey及合作者加速的AlphaFold2，需要注册，提供GPU，虽然免费版本有一些限制，但也基本够用，每天可以算几个任务）。
1. 在“query_sequence”里贴进要预测的序列，随便起个好记的“jobname”，这里“template_mode”我们暂时选择none，也就是不用模板进行“从头预测”。填好后从菜单栏“Runtime”中选择“Run all”即可等待最后结果产生。需要注意colab页面如果长时间不操作会断掉，短时间还可以重连，时间稍长计算资源会被回收那就白算了，注意过十来分钟滚动一下页面，一般半个小时结果就出来了。最后选择允许自动下载，以后就算断了结果也都已经存下来。运行过程中会首先初始化一些参数，下载需要的软件和数据库，用mmseqs搜索MSA，然后进行推理。默认会采用AF2提供的5个模型各算一个结构。首先会出来一个MSA搜索的结果，图可以看出query序列的同源序列覆盖情况，一般sequence identity>30会被认为结构上较为相似（虽然可能并没有得到），可以为推理提供有价值的信号。经验上如果有上百条这样的MSA，就可以得到不错的结构预测结果，当然这也会与序列长度和本身的难易程度有关。

### 蛋白-多肽复合物建模
1. 前述步骤同“蛋白建模”，只要在预测序列中用冒号将多条链分开，就可以进行复合物预测，蛋白-蛋白、蛋白-多肽，操作都是一样的，略有不同的是，蛋白蛋白互作还可能通过配对的MSA得到额外inter-chain的辅助信息。
1. 选择“pdb100”模板（这里也可以自己定制模板，但注意文件命名要和pdb的方式一致，比如abcd.pdb）
1. 同样“Run all”，得到MSA部分与之前类似，但多肽完全没有信号。
1. 如果具有一些场外信息（比如N端部分无结构，C端domain不参与多肽结合），研究蛋白与底物肽的复合物可以只需考虑底物结合域，也就是完整序列75-439这一区间，提高计算效率。

### 小分子对接
1. 打开深度学习模型共享网站Huggingface上可以免费使用的小分子对接工具[diffdock页面](https://huggingface.co/spaces/simonduerr/diffdock)。
1. 将pdb拖入左边（删除不想关残基），将小分子的SMILES（从pubchem网站下载或用chemdraw/kingdraw生成）贴入右边。
1. 点击“Run predictions”，几分钟就会得到结果。
1. 将rank1.sdf和蛋白pdb在同一个pymol中打开，就可以看到预测的docking结果。

### 参考
1. [教程 结构预测新工具如何帮助研究](https://mp.weixin.qq.com/s/nL6vnXNj-EpDcuxB4JcZmw)

![](/img/wc-tail.GIF)
