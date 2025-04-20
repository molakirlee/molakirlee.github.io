---
layout:     post
title:      "GAMS 入门"
subtitle:   ""
date:       2024-07-16 21:38:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - GAMS
    - 2024

---


### 教程
1. 入门case[A GAMS Tutorial by Richard E. Rosenthal](https://www.gams.com/latest/docs/UG_Tutorial.html)
1. 算例数据库[The GAMS Model Library](https://www.gams.com/latest/gamslib_ml/libhtml/index.html#gamslib)
1. [教程及算例: Handbook of Test Problems in Local and Global Optimization](http://titan.princeton.edu/TestProblems/)
1. [OONLP:a Scatter Search Multistart Approach for Solving Constrained Non- Linear Global Optimization Problems](https://www.gams.com/archives/presentations/present_lasdon.pdf?search=cstr)

1. [GAMS(V49) Documentation Center(右上角可切换不同version)](https://www.gams.com/49/docs/index.html)

1. [User's Guide:This documentation guides GAMS users through several topics in the GAMS system.](https://www.gams.com/47/docs/UG_MAIN.html#UG_Tutorial_Examples)
1. [GAMS -- A User's Guide Tutorial by Richard E. Rosenthal](https://www.un.org/en/development/desa/policy/mdg_workshops/training_material/gams_users_guide.pdf)
1. []()

### 注意事项
1. The model cannot be referenced before it is declared to exist
1. Multiple lines per statement, embedded blank lines, and multiple statements per line are allowed
1. Terminate every statement with a semicolon
1. GAMS compiler does not distinguish between upper-and lowercase letters
1. There are at least two ways to insert documentation within a GAMS model. First, any line that starts with an asterisk in column 1 is disregarded as a comment line by the GAMS compiler. Second, perhaps more important, documentary text can be inserted within specific GAMS statements. All the lowercase words in the transportation model are examples of the second form of documentation.

1. The creation of GAMS entities involves two steps: a declaration and an assignment or definition
1. The names given to the entities of the model must start with a letter and can be followed by up to nine more letters or digits.

1. 求解不出来时，可以考虑先将部分关键变量'.fx'住，方便分析。


###### Sets
1. 变量名称不能有空格，可以用hyphens或者单/双引号
1. 一组变量在一行Set时，变量之间用星号，比如`Set    m   machines             /mach1*mach24/;`等价于`m={mach1,mach2...,mach24}`

###### Data
1. Data数据类型：List是、Tables、Direct assignments
1. The entire list must be enclosed in slashes and that the element-value pairs must be separated by commas or entered on separate lines.
1. There is no semicolon separating the element-value list from the name, domain, and text that precede it
1. A scalar is regarded as a parameter that has no domain. It can be declared and assigned with a Scalar statement containing a degenerate list of only one value.
1. The direct assignment method of data entry differs from the list and table methods in that it divides the tasks of parameter declaration and parameter assignment between separate statements.It is important to emphasize the presence of the semicolon at the end of the first line. Without it, the GAMS compiler would attempt to interpret both lines as parts of the same statement.
1. The same parameter can be assigned a value more than once. Each assignment statement takes effect immediately and overrides any previous values. In contrast, the same parameter may not be declared more than once. 
1. The right-hand side of an assignment statement can contain a great variety of mathematical expressions and built-in functions.

###### Variables
1. The decision variables (or endogenous variables ) of a GAMS-expressed model must be declared with a Variables statement. Each variable is given a name, a domain if appropriate, and (optionally) text.  
1. The variable that serves as the quantity to be optimized must be a scalar and must be of the free type. 

###### Equation
1. Equations must be declared and defined in separate statements. 
1. Equation has a broad meaning in GAMS. It encompasses both equality and inequality relationships, and a GAMS equation with a single name can refer to one or several of these relationships.
1. The '=' symbol is used only in direct assignments, and the '=e=' symbol is used only in equation definitions. 
1. 

######  求解器推荐
1. BARON
1. SCIP
1. 这两个可适用于MINLP、NLP等问题，其它的都不如这两个好；哪个快不一定，取决于具体问题.

###### 读写
1. [Data Exchange with Microsoft Excel](https://www.gams.com/48/docs/UG_DataExchange_Excel.html)


```GAMS
Set i 'canning plants', j 'markets';

Parameter d(i<,j<)  'distance in thousands of miles'
          a(i)      'capacity of plant i in cases'
          b(j)      'demand at market j in cases';

$onEmbeddedCode Connect:
- ExcelReader:
    file: input.xlsx
    symbols:
      - name: d
        range: distance!A1
      - name: a
        range: capacity!A1
        columnDimension: 0
      - name: b
        range: demand!A1
        rowDimension: 0
- GAMSWriter:
    symbols: all
$offEmbeddedCode
```

在V49中可以对`- GAMSWriter:`使用`symbols: all`，在V47中则不识别，需使用`- name : d`的形式，具体可参见对应版本的help.



![](/img/wc-tail.GIF)
