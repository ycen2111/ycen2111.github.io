---
title: Git Command
date: 2022-11-04 13:52:45
tags:
- Git
- Basic Command
categories: 
- Git
---

Git 语句和 GutHub 简单使用流程

<!-- more -->

教程：[https://www.runoob.com/git](https://www.runoob.com/git)

# 下载git
[git官网地址](https://gitforwindows.org/)
会一同下载Git GUI，Git CMD和Git Bash
Git Bash不能像Linux使用sudo命令，如有需要则要下载Node.js里的npm功能代替。
[nodejs下载地址](https://nodejs.org/en/download/)
记得翻墙

这里使用的是 git 2.33.0.windows.2, node v16.8.0, npm 7.21.0

# 建立本地仓库
![001.png](001.png)
workspace：本地文件夹
staging area：暂存区/缓存区
local repository：版本库或本地仓库
remote repository：远程仓库
打开需要作为仓库的文件夹，在文件夹里打开Git Bash，
输入
``` Bash
git init #初始化仓库
#成功会显示：Initialized empty Git repository in XXX
```
此时如果显示隐藏文件，会找到一个隐藏的".git"文件，如果将其删除则会同样删除仓库。
之后输入
``` Bash
git add . #将文件从文件夹存至暂存区
git status #检查仓库文件和暂存区文件是否一样
#如暂存区多了文件会绿色显示，如文件夹多了文件未存至暂存区会以红色提示使用add命令
git rm [fileName] #将文件从暂存区和文件夹中删除
git rm --cached [fileName] #只将文件从暂存区删除
git reset #删除暂存区内全部文件
git commit -m "CommitName" #将文件从暂存区上传本地仓库
git commit -am "CommitName" #可直接将文件上传本地仓库
```

## 远程仓库上传
先确保注册了github账号，并建立了远程仓库
Bash登录github和SSH相关可看[Hexo个人博客创建引导（二）](https://pipirima.top/Hexo%E4%B8%AA%E4%BA%BA%E5%8D%9A%E5%AE%A2%E5%88%9B%E5%BB%BA%E5%BC%95%E5%AF%BC/Hexo%E4%B8%AA%E4%BA%BA%E5%8D%9A%E5%AE%A2%E5%88%9B%E5%BB%BA%E5%BC%95%E5%AF%BC%EF%BC%88%E4%BA%8C%EF%BC%89-cee5c8cdb4b0/#%E7%94%9F%E6%88%90SSH)
``` Bash
git remote add [ReposioryName] [url] #连接本地仓库和远程仓库
# 如： git remote add LittlePrograme https://github.com/ycen2111/Little-Programe.git
```
再打开.git -> config 会看见已经添加了远程仓库的信息
``` Bash
git push -u [ReposioryName] [branchName] #上传到仓库的指定branch，之后再上传就不用输入-u了，已经指定该branch为默认branch了
git push [ReposioryName] [branchName]
#如：git push origin master
```

但注意git会删除缺少的内容然后重新上传，需谨慎
``` Bash
git add *
git commit -m "#"
git push origin master #正常上传三部曲

git add * && git commit -m "#" && git push origin master

if [ $? -ne 0 ]; then
read -n 1
exit
fi
```

Please note: 如果单个文件过大(>100M)，会被拒绝上传

如果遇到无法更新云端文件的问题(git changes not staged for commit)，可尝试将git add *改为git add ./