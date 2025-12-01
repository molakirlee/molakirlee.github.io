---
layout:     post
title:      "fftw 查找·卸载"
subtitle:   ""
date:       2025-11-15 21:27:00
author:     "XiLock"
header-img: ""
header-mask: 0.3
catalog:    true
tags:
    - 《斤竹精舍·游艺集》
    - Linux
    - 2025

---
 
要彻底卸载单精度或双精度的FFTW（Fastest Fourier Transform in the West），需根据**安装方式**（源码编译安装、包管理器安装如apt/yum/homebrew）和**系统环境**（Linux/macOS）针对性操作，核心是删除对应版本的库文件、头文件和配置文件，避免残留。以下是分步指南：


### 一、先确认FFTW的安装方式和版本路径
首先需要明确：你要卸载的是“单精度”（`float` 类型，库名通常含 `fftw3f`）还是“双精度”（`double` 类型，库名通常含 `fftw3`），以及它们的安装路径（避免误删）。

#### 1. 查看已安装的FFTW库文件
FFTW的库文件（`.so`/`.a`/`.dylib`）和头文件（`fftw3.h`/`fftw3f.h`）通常位于以下路径：
- 系统默认路径：`/usr/lib`、`/usr/lib64`、`/usr/include`
- 自定义路径（源码安装时指定）：`/usr/local/lib`、`/usr/local/include`、`~/local/lib` 等

执行以下命令搜索对应版本的库文件（以Linux为例，macOS类似，将 `so` 替换为 `dylib`）：
```bash
# 搜索双精度FFTW（库名：libfftw3.*）
find /usr /usr/local ~ -name "libfftw3.*" 2>/dev/null

# 搜索单精度FFTW（库名：libfftw3f.*）
find /usr /usr/local ~ -name "libfftw3f.*" 2>/dev/null
```
- 输出结果中，`libfftw3.so`/`libfftw3.a` 对应**双精度**，`libfftw3f.so`/`libfftw3f.a` 对应**单精度**。
- 记录这些文件的路径（如 `/usr/local/lib/libfftw3f.so`），后续针对性删除。

#### 2. 确认安装方式
- 若通过包管理器安装（如Ubuntu的 `apt`、CentOS的 `yum`、macOS的 `brew`）：直接用包管理器卸载（最干净）。
- 若通过源码编译安装（`./configure && make && make install`）：需手动删除安装的文件（无自动卸载脚本时）。


### 二、按安装方式卸载目标版本
#### 场景1：通过包管理器安装（推荐优先用此方式）
包管理器会记录安装的文件路径，卸载时能自动清理，无残留。

##### （1）Debian/Ubuntu 系统（apt）
先查看已安装的FFTW包（区分单/双精度）：
```bash
# 列出所有与fftw相关的已安装包
dpkg -l | grep fftw
```
- 双精度包名：`libfftw3-dev`（开发版，含头文件）、`libfftw3-3`（运行时库）
- 单精度包名：`libfftw3f-dev`（开发版）、`libfftw3f-3`（运行时库）

卸载目标版本（以卸载单精度为例）：
```bash
# 卸载单精度开发版+运行时库（彻底删除）
sudo apt purge libfftw3f-dev libfftw3f-3
# 清理依赖残留
sudo apt autoremove && sudo apt autoclean
```
- 若要卸载双精度：替换为 `sudo apt purge libfftw3-dev libfftw3-3`。

##### （2）CentOS/RHEL 系统（yum）
查看已安装包：
```bash
yum list installed | grep fftw
```
- 双精度包名：`fftw-devel`、`fftw`
- 单精度包名：`fftw-libs-single`、`fftw-devel-single`

卸载单精度示例：
```bash
sudo yum remove fftw-libs-single fftw-devel-single
# 清理缓存
sudo yum clean all
```

##### （3）macOS 系统（Homebrew）
Homebrew的FFTW包默认同时包含单/双精度，但可通过指定版本或手动删除对应库文件分离：
```bash
# 先查看已安装的fftw包
brew list fftw

# 若要彻底卸载整个fftw（含单+双精度），再重装需要的版本
brew uninstall --force fftw
# 重装仅双精度（或单精度，根据需求）
brew install fftw  # 默认含单+双精度，若需仅双精度，需源码编译
```
- Homebrew未提供单独的单/双精度包，若需仅保留一个版本，需后续手动删除不需要的库文件（见场景2）。

#### 场景2：通过源码编译安装（无包管理器记录）
若当初通过 `./configure && make && make install` 安装，需手动删除目标版本的文件（关键：只删对应版本的文件，避免误删另一个版本）。

##### 步骤1：定位安装文件（基于场景1的搜索结果）
假设搜索到：
- 双精度文件（保留）：`/usr/local/lib/libfftw3.so`、`/usr/local/include/fftw3.h`
- 单精度文件（卸载）：`/usr/local/lib/libfftw3f.so`、`/usr/local/lib/libfftw3f.a`、`/usr/local/include/fftw3f.h`

##### 步骤2：删除目标版本的文件
```bash
# 1. 删除单精度库文件（根据实际路径修改）
sudo rm -f /usr/local/lib/libfftw3f.*  # 匹配.so、.a、.la等文件
# 2. 删除单精度头文件
sudo rm -f /usr/local/include/fftw3f.h
# 3. 删除可能的配置文件或pkg-config文件（若存在）
sudo rm -f /usr/local/lib/pkgconfig/fftw3f.pc
```
- 若卸载双精度：替换为 `libfftw3.*` 和 `fftw3.h`。
- 注意：路径必须准确，避免误删系统文件（可先执行 `ls 路径` 确认文件再删除）。

##### 步骤3：更新动态链接库缓存（Linux）
若删除的是动态库（`.so` 文件），需更新系统缓存，避免残留引用：
```bash
sudo ldconfig
```


### 三、验证是否彻底卸载
卸载后，通过以下命令确认目标版本已删除，另一个版本正常保留：
```bash
# 检查单精度是否残留（卸载单精度后执行，应无输出）
find /usr /usr/local ~ -name "libfftw3f.*" 2>/dev/null

# 检查双精度是否正常（应输出保留的文件路径）
find /usr /usr/local ~ -name "libfftw3.*" 2>/dev/null

# 验证编译是否正常（以保留双精度为例）
# 编写测试代码 test_fftw.c（双精度）
#include <fftw3.h>
int main() {
    fftw_complex *in, *out;
    fftw_plan p;
    in = (fftw_complex*)fftw_malloc(sizeof(fftw_complex) * 8);
    out = (fftw_complex*)fftw_malloc(sizeof(fftw_complex) * 8);
    p = fftw_plan_dft_1d(8, in, out, FFTW_FORWARD, FFTW_ESTIMATE);
    fftw_execute(p);
    fftw_destroy_plan(p);
    fftw_free(in); fftw_free(out);
    return 0;
}

# 编译（若双精度正常，应无报错）
gcc test_fftw.c -lfftw3 -o test_fftw
./test_fftw  # 无报错则正常
```


### 四、注意事项
1. **区分库名**：双精度核心是 `fftw3`（无 `f` 后缀），单精度是 `fftw3f`（带 `f` 后缀），切勿混淆删除。
2. **自定义安装路径**：若当初源码安装时指定了 `--prefix=/path/to/install`（如 `~/local`），则所有文件都在该路径下，直接删除该路径下的对应版本文件即可，无需动系统目录。
3. **避免误删系统依赖**：部分软件可能依赖FFTW，卸载前可通过 `ldd /path/to/software` 查看是否依赖目标版本，确认无依赖后再删除。
4. **macOS动态库缓存**：macOS无需手动更新缓存，删除 `.dylib` 文件后自动失效。


### 总结
- 优先用**包管理器卸载**（最干净，自动清理所有文件）；
- 源码安装需**手动删除对应版本的库文件、头文件**，并更新动态链接库缓存；
- 关键是通过 `find` 命令准确定位目标版本的文件，避免误删保留的版本。

按以上步骤操作后，即可彻底卸载不需要的单精度或双精度FFTW，无残留。 
 
 
 
![](/img/wc-tail.GIF)
