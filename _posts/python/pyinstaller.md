---
title: pyinstaller
date: 2022-06-23 12:12:14
tags: 
- 编程
- python
- plugin
categories: 
- python
---

## 介绍

windows打包插件，打包为.exe文件。打包的文件会放在disc folder下。

<!-- more -->

## 安装
``` Bash
pip install pyinstaller
```

## 程序调用
``` Bash
官网：(https://pyinstaller.org/en/stable/usage.html)
#power shell 输入
pyinstaller --name="test" (options) D:\Blog\Hexo\source\_posts\python\openpyxl.md

#options:
--help #show help message
--windowed #donot open console window
--console #open console window

--onefile #ouput one file exe file (fit for single file program)
--onedir #output one dir file (fir for multiple file program)

--icon=".\icon" #change default icon (must in form of .ico)

#example
pyinstaller --name="test" --windowed --onefile --icon=".\icon" .\openpyxl.py
```

## 注意事项
### 头文件
import头文件尽量减少，多用from少直接import来减少打包程序大小和加快运行速度

### 打包的文件数
multi-file程序尽量使用 --onedir 加快开启速度