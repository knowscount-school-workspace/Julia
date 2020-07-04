# 初识 Julia。

<img src="/Users/admin/Library/Application Support/typora-user-images/image-20200704092747314.png" alt="image-20200704092747314" style="zoom:50%;" />

---



数据分析？

<img src="/Users/admin/Library/Application Support/typora-user-images/image-20200704092803566.png" alt="image-20200704092803566" style="zoom:50%;" />

速度？

<img src="/Users/admin/Library/Application Support/typora-user-images/image-20200704093023642.png" alt="image-20200704093023642" style="zoom:50%;" />

### 速度对比在 b 站上有。[链接](https://www.bilibili.com/video/BV1wk4y167Qa?from=search&seid=13475921069345470554)

运行代码，得到 Julia 须 **0.58** 秒的事情，

Python 要 **52.8** 秒

---

开启正文。

## 一 · Julia 安装。

Julia 在它的官网上给出了给各个平台的安装包。有：

[**Windows (.exe 64-bit)**](https://julialang-s3.julialang.org/bin/winnt/x64/1.0/julia-1.0.5-win64.exe)

[**Windows (.exe 32-bit)**](https://julialang-s3.julialang.org/bin/winnt/x86/1.0/julia-1.0.5-win32.exe)

[**macOS 10.8+ (.dmg 64-bit)**](https://julialang-s3.julialang.org/bin/mac/x64/1.0/julia-1.0.5-mac64.dmg)

[**Generic Linux Binaries for x86 (64-bit)**](https://julialang-s3.julialang.org/bin/linux/x64/1.0/julia-1.0.5-linux-x86_64.tar.gz) ([**GPG**](https://julialang-s3.julialang.org/bin/linux/x64/1.0/julia-1.0.5-linux-x86_64.tar.gz.asc))

[**Generic Linux Binaries for x86 (32-bit)**](https://julialang-s3.julialang.org/bin/linux/x86/1.0/julia-1.0.5-linux-i686.tar.gz) ([**GPG**](https://julialang-s3.julialang.org/bin/linux/x86/1.0/julia-1.0.5-linux-i686.tar.gz.asc))

[**Generic Linux Binaries for ARM (64-bit, AArch64)**](https://julialang-s3.julialang.org/bin/linux/aarch64/1.0/julia-1.0.5-linux-aarch64.tar.gz) ([**GPG**](https://julialang-s3.julialang.org/bin/linux/aarch64/1.0/julia-1.0.5-linux-aarch64.tar.gz.asc))

[**Generic Linux Binaries for ARM (32-bit, ARMv7-a hard float)**](https://julialang-s3.julialang.org/bin/linux/armv7l/1.0/julia-1.0.5-linux-armv7l.tar.gz) ([**GPG**](https://julialang-s3.julialang.org/bin/linux/armv7l/1.0/julia-1.0.5-linux-armv7l.tar.gz.asc))

[**Generic FreeBSD Binaries for x86 (64-bit)**](https://julialang-s3.julialang.org/bin/freebsd/x64/1.0/julia-1.0.5-freebsd-x86_64.tar.gz) ([**GPG**](https://julialang-s3.julialang.org/bin/freebsd/x64/1.0/julia-1.0.5-freebsd-x86_64.tar.gz.asc))

也给了源码：

[**Source (Tarball)**](https://github.com/JuliaLang/julia/releases/download/v1.0.5/julia-1.0.5.tar.gz) ([**GPG**](https://github.com/JuliaLang/julia/releases/download/v1.0.5/julia-1.0.5.tar.gz.asc))

[**Source (Tarball with Dependencies)**](https://github.com/JuliaLang/julia/releases/download/v1.0.5/julia-1.0.5-full.tar.gz) ([**GPG**](https://github.com/JuliaLang/julia/releases/download/v1.0.5/julia-1.0.5-full.tar.gz.asc))

[**Source (Github)**](https://github.com/JuliaLang/julia/tree/v1.0.5)

以上都是 1.42 的 stable release 下内容。

不过我在 macOS 上这样安装遇到了点问题……我在终端里执行 ` julia  `指令后，它会报错

```bash
bash: julia: command not found
```

网上看了看几个解决方案都不可行。——于是最终我还是屈服于 `brew` 的淫威。

```bash
brew cask install julia
```

装好了之后试着在命令行输入 ```julia```，它应该会将你带到它的 REPL 里头。

和上次一样，Windows 甚么由于没有实操实在不清楚，祝你们好运。嗯，我真负责任。

---

## 二 · Julia 扩展包。

[到这去](https://julialang.org/packages/)

Julia 的基本语言比较精炼， 许多功能都需要依赖扩展包 (packages) 完成， 一些基本的语言功能也放到了 Base 扩展包中， Base 扩展包中的函数都是直接可以使用的， 不需要单独安装和声明。

为了调用某个扩展包的功能， 一般只要用 `using` 即可。例如：

```bash
using Statistics
```

在 Julia 命令行安装扩展包，如 DataFrames，命令如下：

```bash
using Pkg
Pkg.add("DataFrames")
```

安装的扩展包如果不能正常工作， 可以尝试重新构建，如：

```bash
using Pkg
Pkg.build("DataFrames")
```

为了更新已安装的所有包到最新版本， 用命令：

```bash
Pkg.update()
```

---

## 三 · Julia 的基本数据和相应运算。

### ~~四~~五则运算。

| 加   | 减   | 乘   | 除   | 乘方 |
| ---- | ---- | ---- | ---- | ---- |
| +    | -    | *    | /    | ^    |

例如：

```julia
5 + 1 - 3 * (2 / 1)^2
```

输出结果：

```bash
-6.0
```

### 整数与浮点数。

~~Julia 程序中的整数值可以直接写成如 `123` 或者 `-123` 这样。 虽然整数有多种类型， 一般程序中不必特别关心整数常量的具体类型。 Julia 允许使用特别长的整数，这时其类型为 BigInt。~~

~~Julia的浮点数可以写成带点的形式如 `123.0`,  `1.23`, 也可以写成带有10的幂次如 `1.23e3` (表示1.23×1031.23×103), `1.23e-3` (表示1.23×10−31.23×10−3)。 这些写法都属于 Float64 类型的浮点数。 Julia 还有其他类型的浮点数，但是科学计算中主要使用 Float64 类型， 在别的语言中这称为双精度浮点数。~~

上面全是废话，我们不看。

整数 = ……整数就是整数呐

浮点数 = `123.0` 或 `1.230`， 看不懂的话……隔壁去好好学语文，加油奥利给。他就是 “点浮动” 的意思，小数点的位置可以改变。

Julia 还提供了任意精度整数与任意精度浮点数。

布尔类型 Bool 只有两个值：true 和 false。

### 数学函数。

是不是见到这个又兴奋了。/斜眼笑

和其它科学计算语言类似， Julia也支持常见的数学函数，例如 `log`,  `exp`,  `sqrt`,  `sin`,  `cos`,  `tan` 等。

`round(x)` 将 `x` 四舍五入为整数， `round(x, digits=2)` 将 `x` 四舍五入到两位小数。 `floor(x) `求小于等于 `x` 的最大整数， `ceil(x)`求大于等于 `x` 的最小整数。

### 字符串。

#### 先来了解字符。

根据中文文档：

' `Char` 类型的值代表单个字符：它只是带有特殊文本表示法和适当算术行为的 32 位原始类型，不能转化为代表 [Unicode 代码](https://en.wikipedia.org/wiki/Code_point) 的数值。（Julia 的包可能会定义别的 `AbstractChar` 子类型，比如当为了优化对其它 [字符编码](https://en.wikipedia.org/wiki/Character_encoding) 的操作时）`Char` 类型的值以这样的方式输入和显示：

```bash
julia> 'x'
'x': ASCII/Unicode U+0078 (category Ll: Letter, lowercase)

julia> typeof(ans)
Char
```

'你可以轻松地将 `Char` 转换为其对应的整数值，即 Unicode 代码：

```bash
julia> Int('x')
120

julia> typeof(ans)
Int64
```

'在 32 位架构中，[`typeof(ans)`](https://juliacn.gitlab.io/JuliaZH.jl/base/base.html#Core.typeof) 将显示为 [`Int32`](https://juliacn.gitlab.io/JuliaZH.jl/base/numbers.html#Core.Int32)。你可以轻松地将一个整数值转回 `Char`。

```bash
julia> Char(120)
'x': ASCII/Unicode U+0078 (category Ll: Letter, lowercase)
```

'并非所有的整数值都是有效的 Unicode 代码，但是为了性能，`Char` 的转化不会检查每个值是否有效。如果你想检查每个转换的值是否为有效值，请使用 [`isvalid`](https://juliacn.gitlab.io/JuliaZH.jl/base/strings.html#Base.isvalid-Tuple{Any}) 函数：

```bash
julia> Char(0x110000)
'\U110000': Unicode U+110000 (category In: Invalid, too high)

julia> isvalid(Char, 0x110000)
false
```

'目前，有效的 Unicode 码点为，从 `U+0000` 至 `U+D7FF`，以及从 `U+E000` 至 `U+10FFFF`。 它们还未全部被赋予明确的含义，也还没必要能被程序识别；然而，所有的这些值都被认为是有效的 Unicode 字符。

'你可以在单引号中输入任何 Unicode 字符，通过使用 `\u` 加上至多 ４ 个十六进制数字或者 `\U` 加上至多 ８ 个十六进制数（最长的有效值也只需要 6 个）：

```bash
julia> '\u0'
'\0': ASCII/Unicode U+0000 (category Cc: Other, control)

julia> '\u78'
'x': ASCII/Unicode U+0078 (category Ll: Letter, lowercase)

julia> '\u2200'
'∀': Unicode U+2200 (category Sm: Symbol, math)

julia> '\U10ffff'
'\U10ffff': Unicode U+10FFFF (category Cn: Other, not assigned)
```

'Julia 使用系统默认的区域和语言设置来确定，哪些字符可以被正确显示，哪些需要用 `\u` 或 `\U` 的转义来显示。除 Unicode 转义格式之外，还可以使用所有的[传统 C 语言转义输入形式](https://en.wikipedia.org/wiki/C_syntax#Backslash_escapes)：

```bash
julia> Int('\0')
0

julia> Int('\t')
9

julia> Int('\n')
10

julia> Int('\e')
27

julia> Int('\x7f')
127

julia> Int('\177')
127
```

'你可以对 `Char` 的值进行比较和有限的算术运算：

```bash
julia> 'A' < 'a'
true

julia> 'A' <= 'a' <= 'Z'
false

julia> 'A' <= 'X' <= 'Z'
true

julia> 'x' - 'a'
23

julia> 'A' + 1
'B': ASCII/Unicode U+0042 (category Lu: Letter, uppercase)
```

~~哈哈哈哈哈哈哈哈哈哈哈哈哈 copy paste 就爽~~

我这个人从来都是原创。

#### 梦回字符串

单个字符在两边用单撇号界定，如 `'A'`，`'囧'`。 字符都是用 Unicode 编码存储，具体使用UTF-8编码。 每个字符可能使用 1 到 4 个字节表示。 字符的类型为 Char， 自定义函数中的字符参数可声明为 AbstractChar。

零到多个字符组成字符串， 程序中的字符串在两边用双撇号界定，如 `"A cat"`，`"泰囧"`。 字符串数据类型名称为 String， 自定义函数中的字符串参数可声明为 AbstractString。

对于占据多行的字符串， 可以在两侧分别用三个双撇号界定。如

```julia
"""
这是第一行
这是第二行
三个双撇号界定的字符串中间的单个双撇号"不需要转义
"""
```

注意多行内容的首行不需要紧挨着写在开头的三个双撇号后面同一行内。

字符串属于不可修改类型(immutable)， 即不能直接修改字符串的内容， 但可以给保存了字符串的变量赋值为一个新的字符串。

用星号 '`*`' 连接两个字符串，也可以将字符连接成字符串，如

```julia
'#' * "这是" * "美好的一天" * "。"
```

