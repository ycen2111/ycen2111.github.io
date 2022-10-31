---
title: TKinter
date: 2022-07-24 13:36:37
tags: 
- 编程
- python
- plugin
categories: 
- python
---

## 介绍

Python自带GUI pack，easyGUI底层pack。以python底层编写，所以无法处理复杂逻辑，但处理简单问题比QT等以C为底层pack更方便。

<!-- more -->

## 程序调用
``` Bash
官网：(https://docs.python.org/3.7/library/tkinter.html)
说明：(http://c.biancheng.net/tkinter/)

from tkinter import *
from tkinter import ttk

root = Tk() #create a root widget
root.title("TK") #set title
root.geometry("600x400+20+20") #set window with 600x400 pixcel, left-up corner in position (20,20)
frm = ttk.Frame(root, padding=10) #create a frame based on root
frm.grid() #easy placement based on column and row

lb=ttk.Label(frm, text="Label") #label box
lb.grid(row=0,column=0) #pack label into grid

entry=ttk.Entry(frm) #enter box
enter.delete(0,"end") #remove contents
enter.insert(0,"insert") #input string "Insert" in enter box
enter.grid(row=0,column=1)

quit_button=ttk.Button(frm, text="Quit1", command=root.destroy) #quit button box
quit_button.grid(row=1,column=0,columnspan=2) #span 2 column cells

Can=Canvas(frm,height=300,width=200) #create a canvas
cell=Canvas.create_rectangle(2, 2, 20, 20, fill = "black") #a reactangle filled with black, in range (2,2) to (20,20)
Can.delete(ALL) #remove all copoments in canvas

Can.bind("<ButtonPress-1>",mouse_event) #mouse event and commanf funciton

def mouse_event(event):
    lb.config(text=event) #change label text

    root.after(300,mouse_event) #repeat mouse_event function after 300ms

root.mainloop() #start load window
```

## 事件列表
``` Bash
<ButtonPress-1>     单击鼠标左键，简写为<Button-1>，后面的数字可以是1/2/3，分别代表左键、中间滑轮、右键
<ButtonRelease-1>	释放鼠标左键，后面数字可以是1/2/3，分别代表释放左键、滑轮、右键
<B1-Motion>	        按住鼠标左键移动，<B2-Motion>和<B3-Motion>分别表示按住鼠标滑轮移动、右键移动
<MouseWheel>	    转动鼠标滑轮
<Double-Button-1>	双击鼠标左键
<Enter>	            鼠标光标进入控件实例
<Leave>	            鼠标光标离开控件实例
<Key>	            按下键盘上的任意键
<KeyPress-字母>/<KeyPress-数字>	按下键盘上的某一个字母或者数字键
<KeyRelease>	    释放键盘上的按键
<Return>	        回车键，其他同类型键有<Shift>/<Tab>/<Control>/<Alt>
<Space>	            空格键
<UP>/<Down>/<Left>/<Right>	方向键
<F1>...<F12>	    常用的功能键
<Control-Alt>	    组合键，再比如<Control-Shift-KeyPress-T>，表示用户同时点击 Ctrl + Shift + T
<FocusIn>	        当控件获取焦点时候触发，比如鼠标点击输入控件输入内容，可以调用 focus_set() 方法使控件获得焦点
<FocusOut>	        当控件失去焦点时激活，比如当鼠标离开输入框的时候
<Configure >	    控件的发生改变的时候触发事件，比如调整了控件的大小等
<Deactivate>	    当控件的状态从“激活”变为“未激活”时触发事件
<Destroy>	        当控件被销毁的时候触发执行事件的函数
<Expose>	        当窗口或组件的某部分不再被覆盖的时候触发事件
<Visibility>	    当应用程序至少有一部分在屏幕中是可见状态时触发事件

widget	        发生事件的是哪一个控件
x,y	            相对于窗口的左上角而言，当前鼠标的坐标位置
x_root,y_root	相对于屏幕的左上角而言，当前鼠标的坐标位置
char	        用来显示所按键相对应的字符
keysym	        按键名，比如 Control_L 表示左边的 Ctrl 按键
keycode	        按键码，一个按键的数字编号，比如 Delete 按键码是107
num	            1/2/3中的一个，表示点击了鼠标的哪个按键，按键分为左、中、右
width,height	控件的修改后的尺寸，对应着 <Configure>事件
type	        事件类型
```

## 注意事项
### 界面生成
"x"为小写x，不能是"*"
``` Bash
root.geometry("600x400+20+20")
```

### Components 回调函数提前运行或不运行
如button等component是默认无variable交换和return的，如果有variable会在开始时运行一遍并之后不再运行。
解决方法是在开头加上"lambda:"，但仍然不能返回值
并且没有variables和return值的话最好将"()"去除，不然会有Bool cannot callback的报错

``` Bash
ttk.Button(frm, text="Reset", command=reset_command(10,10,Can)) #Wrong, cannot using
ttk.Button(frm, text="Start", command=start_button()) #Wrong, get error

ttk.Button(frm, text="Reset", command=lambda:reset_command(10,10,Can)) #Correct
ttk.Button(frm, text="Start", command=start_button) #Correct
```

### 函数循环运行
不能单纯用"While(1)"进入循环，不然TK window会显示无响应并卡住不动，尽管程序是照常循行的。
另外如果after内的函数没有variable的话不需要"()"，不然会有递归报错。

like：
``` Bash
root.after(300,start_button()) #wrong!!! recursion error might happened

root.after(300,start_button) #correct

root.after(300,start_button,count) #can pass the variable to function start_button(count)
```