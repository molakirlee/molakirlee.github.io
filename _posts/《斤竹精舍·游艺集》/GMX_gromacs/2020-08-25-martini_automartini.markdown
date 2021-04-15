---
layout:     post
title:      "gmx Martini力场粗粒化-实操auto_martini"
subtitle:   ""
date:       2020-08-25 11:08:00
author:     "XiLock"
header-img: "img/post-background/bamboo3.jpg"
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GMX学习记录
    - 2020


---

**感谢李老师和吴伟学长的指导，搞得几次，实在是太痛苦了**  


使用auto-martini生成小分子/非标准残基拓扑

### 安装
注意auto-martini不兼容python 3.x，要在python 2.7下安装编译。
1. 从github上下载[auto-martini](https://github.com/tbereau/auto_martini)  
1. 下载Windows版的anaconda2. 注意, 这里要选择python2.7版本的, 因为auto-martini是用python2.7写的, 不兼容python3之后的语法
1. 安装完anaconda之后, 以管理员身份运行anaconda, 进入auto-martini包所在位置
1. 创建自定义的rdkit环境并安装所需的包

```
conda create -n py27-env python=2.7
conda activate py27-env
conda install -c conda-forge rdkit
pip install numpy
pip install beautifulsoup
pip install requests
pip install lxml
pip install Pillow

```
1. 一般创建完环境后就有numpy；
1. 若缺少其它包则使用 `pip install xxx`来安装，安装完用`pip list`和`conda list`瞅瞅都有啥包了;
1. 脚本中用到的sanifix4.py包不是pip下载的而是脚本压缩包里的，跟脚本放到同一目录下即可。

使用前进入相应的环境下： `conda activate py27-env`


### 测试
用openbabel将pdb文件转换为sdf文件后，调用auto-martini：
`python auto-martini [-h] (--sdf SDF | --smi SMI) --mol MOLNAME [--xyz XYZ] [--gro GRO] [--verbose] [--fpred]`

其中：
1. --sdf和--smi: 输入文件, 指定其中一个就可以. 可以使用openbabel将pdb或其他格式的文件转化为sdf或者smi文件.
1. --mol: 必须选项, 输出文件中残基的名称
1. --xyz, --gro: 可选的输出文件
1. --verbose, --fpred: 无法找到符合的参数时, 使用按原子或按片段判别珠子的方法, 准确度较差

如：`python auto_martini --sdf dopa.sdf --mol DAH --gro dopa_CG.gro`  
有时会显示无--gro选项

完事用`python auto-martini --smi "N1=C(N)NN=C1N" --mol GUA`测试，屏幕输出：  
```
;;;; GENERATED WITH auto-martini
; INPUT SMILES: N1=C(N)NN=C1N
; Tristan Bereau (2014)

[moleculetype]
; molname       nrexcl
  GUA           2

[atoms]
; id    type    resnr   residu  atom    cgnr    charge  smiles
  1     SP1     1       GUA     S01     1       0     ; Nc1ncnn1
  2     SP1     1       GUA     S02     2       0     ; Nc1ncnn1

[constraints]
;  i   j     funct   length
   1   2     1       0.21
```
但这个算例的sanitize.log文件中可能会提示结构有错，这是因为结构写的有点毛病还是啥。想正儿八经的测试，可以去ZINC库（https://zinc.docking.org/）里下载一个小分子的sdf文件来测试，完事屏幕输出itp文件的内容，sanitize.log里为空。也可以自己用DS/Gview画一个pdb结构然后用OpenBabel转换成sdf，但搞的分子不要太小，像甲烷什么的就歇着吧。

### 注意
1. 用`conda install -c conda-forge rdkit`装的包可能在`factory = ChemicalFeatures.BuildFeatureFactory(fdefName)`这步报错，这是因为BaseFeatures.fdef的安装路径和默认的路径不一致，但`conda install -c conda-forge rdkit`法安装的BaseFeatures.fdef路径太长，win下直接引用可能无法识别，所以可以将`BaseFeatures.fdef`拷贝到当前目录下，然后改下引用路径。

### 其他
###### rdkit是否安装成功可以用下面脚本测试
test  
```
from rdkit import Chem
from rdkit.Chem import Draw
smi = 'CCCc1nn(C)c2C(=O)NC(=Nc12)c3cc(ccc3OCC)S(=O)(=O)N4CCN(C)CC4'
m = Chem.MolFromSmiles(smi)
Draw.MolToImageFile(m,"mol.png")
```
用`python test`执行之后得到png图说明能rdkit正常使用。  

### 参考资料：
1. [MARTINI粗粒化力场简明教程](https://zhuanlan.zhihu.com/p/93216681)
1. [吴伟：auto-martini的安装和使用简介](https://jerkwin.github.io/2019/08/05/%E5%90%B4%E4%BC%9F-auto-martini%E7%9A%84%E5%AE%89%E8%A3%85%E5%92%8C%E4%BD%BF%E7%94%A8%E7%AE%80%E4%BB%8B/)
1. [Martini实例教程：蛋白质](https://jerkwin.github.io/2016/10/11/Martini%E5%AE%9E%E4%BE%8B%E6%95%99%E7%A8%8BPro/)
1. [Martini实例教程：新分子的参数化](https://jerkwin.github.io/2016/10/10/Martini%E5%AE%9E%E4%BE%8B%E6%95%99%E7%A8%8BMol/)

![](/img/wc-tail.GIF)
