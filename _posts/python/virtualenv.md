---
title: virtualenv
date: 2022-08-08 23:51:21
tags:
- 编程
- python
- plugin
categories: 
- python
---

## 介绍

Virtual Python 环境搭建，可轻易实现不同项目的版本隔离。便于操作，但不擅长大项目的版本迁移和更新，已基本被淘汰。大项目管理可参考PDM。

<!-- more -->

## 安装
油管视频教程:(https://www.youtube.com/watch?v=N5vscPTWKOk)

``` Bash
pip install virtualenv

#installed pack
distlib-0.3.5 
filelock-3.7.1 
platformdirs-2.5.2 
virtualenv-20.16.3
```

## 方法调用

``` Bash
#在terminal或Power Shell里操作
virtualenv OKR_env #当前目录下创建新虚拟python项目
#created virtual environment CPython3.10.6.final.0-64 in 2512ms
#  creator CPython3Windows(dest=D:\Python\Intern\OKR_env, clear=False, no_vcs_ignore=False, global=False)
#  seeder FromAppData(download=False, pip=bundle, setuptools=bundle, wheel=bundle, via=copy, app_data_dir=C:\Users\86135\AppData\Local\pypa\virtualenv)
#    added seed packages: pip==22.2.2, setuptools==63.4.1, wheel==0.37.1
#  activators BashActivator,BatchActivator,FishActivator,NushellActivator,PowerShellActivator,PythonActivator

.\OKR_env\Scripts\activate #启动虚拟项目，开头出现(OKR_env)
#(OKR_env) PS D:\Python\Intern> 

pip list #查看已有pack
#Package    Version
#---------- -------
#pip        22.2.2
#setuptools 63.4.1
#wheel      0.37.1

pip freeze --local > requirements.txt #在根目录下创建requirements.txt打印pip下载的pack

deactivate #退出当前虚拟python

pip install -r .\requirements.txt #在新虚拟python环境中下载requirements.txt内pack列表
```

## 注意事项
### 修改file interpreter
如出现下载pack但任显示找不到pack，可再次检查VScode在右下角的python版本路径，查看是否file指向了错误的地址