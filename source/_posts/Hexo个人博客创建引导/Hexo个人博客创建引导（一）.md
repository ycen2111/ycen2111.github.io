---
title: Hexo个人博客创建引导（一）
date: 2021-09-07 17:05:29
tags:
- 编程
- 图文教程
- Blog
categories:
- Hexo模板
---

## 总起
此图文教程为基于[Hexo](https://hexo.io/zh-cn/)私人博客框架和github建立自己的网站博客。

此攻略大量参考资料[零基础搭建博客：入门](https://blog.csdn.net/weixin_41800884/article/details/103589663), [hexo史上最全搭建教程](https://blog.csdn.net/sinat_37781304/article/details/82729029),并加入自己的理解及遇到的问题和对此的解决方法。仅作为自己之后的回忆笔记，可能不具备普适性。

<!-- more -->

## 环境搭建

需要环境：
	1.Git
	2.Git bush
	3.Node.js
	4.Github

### 1. Git bush与Node.js安装

Git可于[git官网](https://gitforwindows.org/)安装。点击download直接会开启一个下载进程，直接全程默认安装即可。这个安装包包含如下图所示三个文件：

![Git 安装后的三个文件](Git_Display.png)

其中Git GUI和Git CMD基本不会用到，只需要Git Bash来运行Linux command即可。 （ps：到此处为止Git Bash默认并未识别sudo命令，之后会用Node.js里的npm功能代替。）

完成之后可以打开Bash输入
``` Bash
git --version
```
看看版本
![bash查询Git版本](git_version.PNG)

没有问题后就可以着手开始Node.js的安装了。如果没有墙的问题的话可以去[nodejs](https://nodejs.org/en/download/)官网，不然就老老实实去[国内端点](http://nodejs.cn/download/)下载。一样的。
![nodejs官网图片](nodejs.PNG)

完成后就可以使用npm命令下载了。马上输入
``` Bash
node -v
npm -v
```
看看是否成功。

### 2.下载Hexo

主菜来了，今晚的主角。由于Hexo是基于Node.js框架，所以必须完成上面的几步再安装。

先找个合适的地方创建文件夹存放架构，然后直接在新建的目录下操作。

直接Bash输入命令
``` Bash
npm install -g hexo-cli
```
这条命令可以直接在Hexo官网找到。注意，不清楚是不是墙的原因Bash会花费大量时间下载，并且没有任何提示（会突然暴毙）。因此尽量多注意下下载状况，多读读command里的内容。

老规矩，查下版本。这里使用的是4.3版本。
![hexo版本](hexo_version.png)

安装完成后需要先初始化一下
``` Bash
hexo init filename
```
自己取个合适的名字。它会自己创建一个文件夹来保存东西不需要自己提前创建。有失败的可能性，如果失败需要删掉它之前创建的文件夹，防止报错。

进入那个文件夹，输入
``` Bash
npm install
```
初始化好的文件夹就基本如下图所示：
![Hexo初始化后的文件夹](init_folder.PNG)
有些文件可能发现没有，但之后都会有的。

其中_config.yml非常重要，基本所有关于网页的配置都会在这里。

最后输入三条黄金代码：
``` Bash
hexo clean //清除缓存
hexo g //创建页面
hexo s //本地启动网页
```
之后直接访问 localhost:4000 就可以看见默认的网页模板了。 ctrl+c可以退出本地网页。
![本地网页](web_page.png)

(完)