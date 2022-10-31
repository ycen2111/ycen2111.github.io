---
title: PDFplumber
date: 2022-08-06 09:30:42
tags:
- 编程
- python
- plugin
categories: 
- python
---

## 介绍

读取分析PDF文件，特长分析PDF内文字表格等参数分析

<!-- more -->

## 安装
github 地址:(https://github.com/hbh112233abc/pdfplumber)

``` Bash
pip install pdfplumber

#installed pack
Pillow-9.2.0 
Wand-0.6.9 
cffi-1.15.1 
charset-normalizer-2.1.0 
cryptography-37.0.4 
pdfminer.six-20220524 
pdfplumber-0.7.4 
pycparser-2.21
```

## 程序调用

``` Bash
import pdfplumber #read PDF file

#open pdf file
pdf=pdfplumber.open("pdf_add",password="") #dismiss password if not necessary

#fundemental data
print(pdf.metadata)
# {'Title': 'PowerPoint Presentation', 'Author': 'Zhang, Dongjie', 'CreationDate': "D:20220807125813+01'00'"'ModDate': "D:20220807125813+01'00'", 'Producer': 'Microsoft® PowerPoint® 2019', 'Creator': 'Microsoft® PowerPoint® 2019'}

#read first char in one page
first_page=pdf.page[0].chars[0]
print(first_page)
# {'matrix': (1, 0, 0, 1, 28.032, 479.59), 'fontname': 'Arial-BoldMT', 'adv': 18.91776, 'upright': True, 'x0': 28.032, 'y0': 475.3816, 'x1': 46.94976, 'y1': 495.42159999999996, 'width': 18.917759999999998, 'height': 20.039999999999964, 'size': 20.039999999999964, 'object_type': 'char', 'page_number': 5, 'text': 'W', 'stroking_color': 0, 'non_stroking_color': 0, 'top': 44.578400000000045, 'bottom': 64.61840000000001, 'doctop': 2204.5784}

#print out all chars in one page
print(first_page.extract_text())
```

## 注意事项
### .chars[] 字符读取
只能读取可显示的ASCii字符，而无法显示 "\n" 之类的非显示字符。
如 "mistake \n"，
会显示 .chars[7] 为 " " (space),
而 .chars[8] 不会读取为 "\n" 而是下一行第一个字符，
故一般和 .extract_text() 方法联合使用来分辨换行位置