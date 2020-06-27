# To Install Jupyter

![Jupyter Notebook 基本操作- Chien Hung Chen - Medium](https://miro.medium.com/max/1079/1*TI3yZ-4DQ6gpovnnxvZSoQ.png)

作为一个 macOS 使用者，我先来讲讲 macOS 中对于 Jupyter 的安装。

**第一重要的是，你必须要有 python 才能安装！**

### macOS 下的 Jupyter 安装。

---

首先，如果你与我同样，是使用 ```brew``` 的，那么便可以用其安装。

```bash
brew install jupyter
```

这就是 ``` brew ``` 的好处——多简单呐。

---

不过如果你是没有用 ```brew``` 的，你可以试着去装一个，或者使用 python 的 ```pip``` 指令。

由于 macOS 下自己安装了 python2.7，所以默认的 pip 便是 2.7 的，直接使用：

```bash
pip install --upgrade pip
pip install jupyter
```

不过如果你想用 python3.x，请去自己安装，然后运行如下：

```bash
pip3 install --upgrade pip
pip3 install jupyter
```

如上两个都是先升级成最高版本的 ```pip``` ，然后安装。

---

或者，你亦可使用 ```Anaconda``` 安装。

```bash
conda install jupyter notebook
```

具体的请看 [这篇简书](https://link.jianshu.com/?t=https%3A%2F%2Fzhuanlan.zhihu.com%2Fp%2F32925500) 了解甚么是 Anaconda。

---

再是说 Windows 下的。

### Windows 下的 Jupyter 安装。

---

Windows 下就没有 ```brew``` 这么好的打包工具了，只可用 ```pip``` 以及 ```Anaconda``` 指令安装。

（以下内容根据 [这篇知乎](https://zhuanlan.zhihu.com/p/54302333)）

使用 ```pip``` 的话，在 cmd 中：

```bash
pip install jupyter
```

**安装成功提示有：jupyter、jupyter-client、jupyter-console、jupyter-core。**

Anaconda 应该一样。



### 运行。

---

若是 ```brew``` 安装的，使用如下指令：

```bash
jupyter notebook
```

若是 ```pip``` 安装的，使用如下指令：

```bash
jupyter notebook 
```
对，就是一样的。

若是有任何对于 Jupyter 的疑问，可以先执行如下试试看：

```bash
jupyter notebook --help
```

抑或

```bash
jupyter notebook -h
```

在执行 ```jupyter notebook``` 指令之后，你应该看到如下：

```bash
$ jupyter notebook
[I 08:58:24.417 NotebookApp] Serving notebooks from local directory: /Users/catherine
[I 08:58:24.417 NotebookApp] 0 active kernels
[I 08:58:24.417 NotebookApp] The Jupyter Notebook is running at: http://localhost:8888/
[I 08:58:24.417 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
```

由第四行 ```[I 08:58:24.417 NotebookApp] The Jupyter Notebook is running at: http://localhost:8888/``` 我们发现，它使用了 8888 端口。如果想使用默认端口，执行：

```bash
jupyter notebook --port <port_number>
```

比如

```bash
jupyter notebook --port 1234
```

同时我们也会发现，一旦执行指令它便会将你转移到浏览器，那如果一个人希望启动服务器但是不跳转浏览器，该怎么做呢，很简单，使用 ```--no-browser``` 也就是：

```bash
jupyter notebook --no-browser
```

这个时候如果你想进入浏览器了，只要在 url 栏里头输入 ‘http://localhost:<port_number>’ 即可。



### 使用。

---

当执行完启动命令之后，浏览器将会进入到 jupyter notebook 的主页面。

它目前的默认目录是在 ```~``` 的，也就是你的用户目录。那么如果你想换掉默认工作路径怎么办？——执行以下命令以先便捷获取配置文件所在路径：

```bash
jupyter notebook --generate-config
```

若文件已经存在，它会说：

```bash
$ jupyter notebook --generate-config
Overwrite /Users/<用户名>/.jupyter/jupyter_notebook_config.py with default config? [y/N]
```

这时输入 ```y``` 即可。

现在进入 ```~/.jupyter/``` 路径，打开其中的 ```jupyter_notebook_config.py``` 文件，找到这一行：

```python
c.NotebookApp.notebook_dir = '<一个路径>'
```

现在将你想要的路径输入，比如我的便是：

```python
c.NotebookApp.notebook_dir = '~/Desktop/Programmes/Jupyter'
```

现在再重启一次，你就会发现 Jupyter 直接进入了你所设置的界面。

新建一个笔记本，开始使用罢！

---

这篇文章目前在 [GitHub](https://github.com/KnowsCount/Julia/blob/master/教程%20Tutorials/Jupyter.md) 上发布；

教学视频目前在 [BiliBili](https://space.bilibili.com/498871842) 上发布。
