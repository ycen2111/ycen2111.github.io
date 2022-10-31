---
title: Hexo个人博客创建引导（二）
date: 2021-09-08 08:43:54
tags:
- 编程
- 图文教程
- Blog
categories:
- Hexo模板
---
## 申请域名
虽然github可以免费生成一个".github.io"结尾的域名，但通常情况下大多数人还是愿意申请一个更适合的域名并重定向过去。由于域名申请审核需要一定时间，这里先介绍域名申请的流程及注意事项，如不打算自己申请可以先跳过这节。

此文会讲解在[阿里云平台](https://wanwang.aliyun.com/domain?utm_content=se_1008364728)申请域名。优点在于阿里云可以直接解析域名，减少工作量，相对方便。
<!-- more -->

![阿里云域名图片](阿里云域名图片.PNG)

个人认为.top结尾的域名便宜又好使，完全可以个人使用，如果可以接受稍微贵点的话.com结尾也比较大气。不同域名价格相差极大，个别热门名字价格可能会到几万，需要多找找。（像此网站域名pipirima.top，就是天蝎座μ2的英文，尾宿增二，3.57等星，双星系统）

找到合适的就直接加入列表购买就行。已购买的可以在域名控制台，域名列表里找到
![域名列表](域名列表.PNG)

一开始购买的域名需要实名认证下，会有提示的，进去后把名字和身份证传下就行。人工审核大概需要半天的样子，完成后会发过来一封信息提醒的，耐心等待即可。审核完成后需要解析下，点击上图蓝色的”解析“即可,这个后面会说。

## github创造仓库

接下来的内容是假设可以登录github并有账号的情况，如果还未注册请先进行注册并完成基础操作。

首先打开仓库
![github仓库.PNG](github仓库.PNG)

在右上角点击绿色的”new“，开始创建。
![创建仓库.PNG](创建仓库.PNG)

（懒得涂名字了，反正都能看到的，算了）

老样子，将yourname改为自己的名字，选择public，直接创建。完成的话像这个样子
![创造完成.PNG](创造完成.PNG)

## 生成SSH

利用bash直接生成密钥，然后把公共密钥给github，就不用每次都属用户名密码了（没试过需要输入的情况，这么说总是方便吧）

如果bash是第一次使用的话先设置一次账号密码。打开bash后输入
``` Bash
git config --global user.name "yourname"
git config --global user.emil "youremail"
```

记得替换好名字和邮箱

然后就生成SSH
``` Bash
ssh-keygen -t rsa -C "youremail"
```

全程回车确认，最后会提示生成完毕，并给一个地址。基本会在 C:\User\.ssh 里找到一个id_rsa.pub
![SSH.PNG](SSH.PNG)

用记事本打开，复制内容后回github黏贴
![github_ssh.PNG](github_ssh.PNG)

点击new ssh key黏贴密钥。

完成后在Bash里输入
``` Bash
ssh -T git@github.com
```

![检查ssh.PNG](检查ssh.PNG)

本人是这个结果，如果出现的话基本就没事了。

## hexo关联github

说是关联，其实也只是将.git等一部分文件上传关联，没有全部发送备份。本文最后有将整个项目上传过程。

打开项目根目录，打开 _config.yml 配置文件直接拖到最后，改为
``` Bash
# Deployment
## Docs: https://hexo.io/docs/one-command-deployment
deploy:
  type: git
  repository: https://github.com/yourname/yourname.github.io.git
  branch: master
```

改为自己名字后保存退出，打开bash安装hexo的部署功能
``` Bash
npm install hexo-deployer-git --save
```

之后我们就可以使用 hexo d 这个命令了。

连续输入
``` Bash
hexo clean
hexo g
hexo d//上传部署
```

hexo d部署估计是由于墙的问题，很容易失败，多试几次发现没提示error就说明成功了。
![部署成功.PNG](部署成功.PNG)

稍微过会儿进入http://yourname.github.io就可以看到上传的页面了。

## 解析域名

之前申请的域名审核通过就可以解析了，不需要认证。

![解析设置.PNG](解析设置.PNG)

（注意！！！）解析设置必须在完成github配置后再进行。

先说主机记录这块，”@“意思是无前缀，直接输入域名就行，如直接pipirima.top就可以访问此网站。”WWW“就是前缀加上，如 www.pipirima.top ,两个都设置的话两个写法都可以访问此网站。

记录类型一般有两个选择，”A“或者”CNAME“。如果选择”A“就需要在记录值这里填写.github.io对应的ip地址。打开windows自带cmd，输入
``` Bash
ping yourname.github.io
```
![git_ip查询.PNG](git_ip查询.PNG)

yourname改为自己的github姓名。在记录值里输入ip即可。

但github方面更推荐使用”CNAME“，如果用”A“在最后github设置customer domain时会有个warning，看着难受。所以一般都是推荐使用”CNAME“。这种情况下直接在记录值输入
``` Bash
yourname.github.io
```

即可，同样记得自己改下名字。

解析线路选择默认，TTL选10分钟即可（更新时间间隔）。点击确认。

## 配置CNAME

最后，再告诉github和hexo新域名

进入仓库中的setting，在page页面内找到customer domain选项
![customer_domain.PNG](customer_domain.PNG)

直接输入域名，不用任何前缀。推荐点上下边的enforce https，更安全一点。点击save，等旁边出现一个绿勾就完成了。

虽然现在就能进入新域名了，但每次部署后都需要从新输入customer domain。解决办法是在本地hexo，source文件夹里新建一个文件，去除后缀（所有格式形式），输入新域名（同样只输入域名进行），重新hexo clean，g，d，部署后就每次可以不用再次输入了。

同样，上传部署后需要等待一会儿，不会马上更新的。

现在可以访问新域名，进行后续的theme选择和内容书写了。

## 备份HEXO文件

为了防止工程文件随本地文件消失而损失，可在仓库中另建一个branch来存放文件。

在github项目仓库中新建branch。

![new_branch.PNG](new_branch.PNG)

在setting中设置默认branch

![set_default.PNG](set_default.PNG)

之后在本地新建一个文件夹来存放已上传的文件：

``` Bash
git clone https://github.com/yourname/yourname.github.io.git
```

开启隐藏文件显示，保留.git文件之外删除其他文件，并将需要上传的文件放进来（必须保留.gitignor文件）。输入

``` Bash
git remote rm origin

git remote add origin https://github.com/yourname/yourname.github.io.git

git add .

git commit -m "something"

git push origin branchName
//if fail
git pull origin branchName
//and follow
git push origin source
```

可发现文件已上传。

Shell 脚本：
``` Bash
git remote rm origin && git remote add origin https://github.com/ycen2111/ycen2111.github.io.git && git add . && git commit -m "backup" && git push origin source
```