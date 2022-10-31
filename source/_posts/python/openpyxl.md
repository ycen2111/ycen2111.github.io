---
title: openpyxl
date: 2022-06-23 11:23:54
tags: 
- 编程
- python
- plugin
categories: 
- python
---

## 介绍

处理Excel文件插件，可以实时读取/写入Excel文件。和panda相比能处理更大文件，但github和社区讨论度不足，维护缓慢。

<!-- more -->

## 安装
``` Bash
pip install openpyxl
```

## 代码调用
官方网站：(https://openpyxl.readthedocs.io/en/stable/tutorial.html)
``` Bash
from openpyxl import load_workbook
from openpyxl import Workbook
from openpyxl.styles import PatternFill #fill cell's background color
add="D:\\Blog\\Hexo\\source\\_posts\\python\\openpyxl.md"

 #open workbook. can increase open speed whenm enable read only option
WB=load_workbook(filename=add,read_only=Truw)
WB=workbook() #create workbook

sheetnames=WB.sheetnames #read sheet names

WS = WB.create_sheet("Mysheet", 0) # insert sheet at position 0
WS=WB.active #open active work sheet, default open sheet 0
WS=WB["Sheet1"] #open target sheet

max_row=WS.max_row #max row index
max_col=WS.max_column #max column index

#copy every cell in sheet
for row in WS.rows:
    for i in row:
        print(i.value())

#read one cell by index
cell=WS.cell(row="1",column="1").value

#rewrite cell value
WS.cell(row="1",column="1",value="value")

#save Excel sheet
WB.save("./test.xlsx")

#fill background color
yellow_color=PatternFill('solid',fgColor='ffff00')
WS.cell(row="1",column="1").fill=yellow_color 
```

## 注意事项
### 打开地址报错
调用load_workbook()时如果出现报错可以注意下输入的地址，如：
``` Bash
#错误示范，程序会认为'\'是分行符而报错
D:\Blog\Hexo\source\_posts\python\openpyxl.md

#正确
D:\\Blog\\Hexo\\source\\_posts\\python\\openpyxl.md
```

### 打包的程序运行缓慢
请尽量避免大量使用代码：
``` Bash
WS.max_row
```
程序会调用大量资源查询max_row，如果运行打包程序会奇慢无比（比VScode里慢30多倍），最好直接保存调用：
``` Bash
max_row=WS.max_row
print(max_row)
```

### 从读取的sheetname无法打开sheet
如想使用读取sheetnames直接打开对应的sheet，需先处理下string格式：
``` Bash
#remove [' '] inside original sheet name
sheet_name=str(sheet_name)[2:len(self.sheet_name)-3]
```

### 无法使用.save()
如果使用save()时报错找不到 tag.getchildren(), 可能是由python升级导致。该tag已在python 3.9之后被 list()替代，可在报错那行替换新的tag：
``` Bash
#previous
tag.getchildren()

#new
list(tag)
```

### 读取value缓慢
如果在openworkbook时enable了read_only会大大减慢每个单元格读取速度，推荐直接disable这块，虽然会减慢文件打开速度但不会影响cell check时效率。