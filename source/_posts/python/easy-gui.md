---
title: easy gui
date: 2022-06-21 19:37:10
tags: 
- 编程
- python
- plugin
categories: 
- python
---

## 介绍

类似一般 APP install guidance 的插件，排版自由度不足，但胜在调用简单方便，配合 FSM(finite state machine) 有奇效。

<!-- more -->

## 安装
``` Bash
pip install easygui
```

## 基本调用语句
官方tutorial:(http://easygui.sourceforge.net/tutorial.html)

``` Bash
import easygui as gui #import gui lib
Button=["A","B","C","D"]

#message box, return string in ok_button
gui.msgbox(msg="Message",title="Title",ok_button="OK") 

#choice box, return choiced string
choice=gui.choicebox(msg="Message",title="Title",choices=Button) 

#button box, return choiced string
choice=gui.buttonbox(msg="Message",title="Title",choices=Button) 

#cancle-continue box, return True if click continue, False if click cancle
choice=gui.ccbox(msg="Message",title="Title",default_choice="continue",cancel_choice="cancle") 

#open file box, return file address
add=gui.fileopenbox(title='Title') 
```

## 注意事项
如果没有有效输入（如直接点关闭键什么的）将会输出 None，注意要设定输出为 None 时的程序逻辑