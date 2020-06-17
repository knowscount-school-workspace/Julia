# Julia 安装

没有 silver bullet, Julia 的特性更多不会有 Python 好学 ( Python 牛逼！而且 Julia 不支持单引号我就很气) 。但是不用担心，上手还是非常容易的。进入主题：

---

## 安装

这应该是最容易的部分了。在[官网](https://julialang.org/)下载安装即可。

鉴于我是 macOS 用户，我便用我的电脑截点图。

![Picture](https://raw.githubusercontent.com/KnowsCount/MarkdownPhotos/master/Res/Screenshot%202020-06-18%20at%205.21.15%20AM.png)

（那两个 Julia 的图标是我改过了的。原图分别是三个点（Julia-1.4.app）和四个点（JuliaPro-1.4.2.app））

---

这个 Julia 1.4 是甚么呢？你能看到，我改的图标上面显示的是 exec，也就说明了这实际上就是一个 REPL。

而那个 JuliaPro-1.4.2 又是？——再次通过图标得出，它就是一个 Atom。

---

现在聪明的你下好了 Julia，而当你下载好了 Julia 之后，不论是 Julia Pro 还是单独的 Julia 编译器，你都可以先打开一个 REPL（交互式编程环境），类似于 IPython 之于 Python ，Julia 的 REPL 支持了基本的代码高亮，文档查看等功能。但是 Julia 的 REPL 更强大（这件事稍后再解释）。

各位应该都是 macOS/Windows，若是如此，双击下载的 Julia，就能打开 REPL。在 Atom 里面的话在左上角有 Julia 一栏，点击里面的 Open Terminal 即可。若是不想用默认的终端打开 Julia，可执行命令 `exec '到 Julia 软件的路径/Contents/Resources/julia/bin/julia'` 来启动（Windows 我不清楚）。

如果是 Linux 的话，事情就有点不一样了。

你需要下载好以后去找到 bin 文件夹，然后把它加入你的 PATH 环境变量里去，以后就可以在命令行里直接通过 `julia` 命令启动 REPL。（这个我就不简单讲了毕竟我的刻板印象告诉我你们是强大的。）