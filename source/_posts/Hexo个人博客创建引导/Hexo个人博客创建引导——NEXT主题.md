---
title: Hexo个人博客创建引导——NEXT主题
date: 2021-09-08 15:03:16
tags:
- 编程
- Blog
categories:
- Hexo模板
---

## 主题更换

在hexo官网有[主题下载](https://hexo.io/themes/)页面，存储有大量主题。如果需要更换就点击进入主题的github页面，按上面的说明步骤直接clone进自己的文件夹就行。下载的文件可以在根目录下的\themes里找到。
<!-- more -->

打开根目录的_config.yml文件，搜索Extensions
``` Bash
# Extensions
## Plugins: https://hexo.io/plugins/
## Themes: https://hexo.io/themes/
theme: next
```

将最后的theme改为新主题的名字即可，本地的话刷新就更换主题了。

现在网站使用的是大佬推荐的[Next](https://github.com/next-theme/hexo-theme-next)主题，内容设置相对丰富点，页面简约动画也不突兀。由于本人next主题使用的相对多点，这篇基本就记录下next里各个configuration，如果之后使用其他主题的话会另开一篇记录。

## 网页设置

网页设置就是在hexo根目录下的_donfig.yml里的内容，一般下载插件或者更改基础设置时会使用。详细介绍可以找[官方文档](https://hexo.io/docs/configuration)。

``` Bash
# Site
title: 朽丶 // 主标题
subtitle: '个人学习记录' //副标题
description: 'Personal Learning Technical Blog' //左边拉框内介绍
keywords:
author: Yang Cen //作者姓名
language: zh-CN //语言设置
timezone: '' 
```

另外可以查找下
``` Bash
permalink: :title-:hash/
```

更多模板可以在[官网](https://hexo.io/docs/permalinks)找到。

## 主题设置

打开themes文件夹里的正在使用的主题文件夹，会发现里边也有个_config.yml文件，这个就是主题的配置文件。此板块会不定期更新，用来记录下理解的模块。

### Schemes

Next主题有四个体系
``` bash
# Schemes
#scheme: Muse
#scheme: Mist
#scheme: Pisces
scheme: Gemini
```

大体是header，left-side排版的变化，推荐都试试看看那个顺眼。由于只能选择一种体系，所以更换时记得注销掉不需要的内容。

### menu

位于标题附近的小目录，使用的话直接去掉之前的“#”即可
``` Bash
menu:
  home: / || fa fa-home
  tags: /tags/ || fa fa-tags
  categories: /categories/ || fa fa-th
  archives: /archives/ || fa fa-archive
  about: /about/ || fa fa-user
  #schedule: /schedule/ || fa fa-calendar
  #sitemap: /sitemap.xml || fa fa-sitemap
  #commonweal: /404/ || fa fa-heartbeat
```

如果全打开效果类似下图
![目录图表.PNG](目录图表.PNG)

如果开启新板块需要bash里输入
``` Bash
hexo new page pat_name
```

然后前往\source，会发现新建了一个同名文件夹，打开里边的index.md,按这个模板配置
``` Bash
---
title: categories
type: "categories"
date: 2021-09-07 11:13:54
comments: false
---
```

完成后就可以使用这些小图标了。

基本上archives,categories,tags需要用的多些，这些不用怎么管的，有文章进去自己就会变化计数。

``` Bash
# Enable / Disable menu icons / item badges.
menu_settings:
  icons: true
  badges: false
```

icons: 之前的小图标
badges：开启会在每条末尾加一个计数表，显示数量

### Social Links

在side bar增加社交app图标和连接。
``` bash
# Social Links
# Usage: `Key: permalink || icon`
# Key is the link label showing to end users.
# Value before `||` delimiter is the target permalink, value after `||` delimiter is the name of Font Awesome icon.
social:
  GitHub: https://github.com/ycen2111 || fab fa-github
  E-Mail: mailto:ycen2111@gmail.com || fa fa-envelope
  #Weibo: https://weibo.com/yourname || fab fa-weibo
  #Google: https://plus.google.com/yourname || fab fa-google
  #Twitter: https://twitter.com/yourname || fab fa-twitter
```
||后的是图标连接，改下前面的网址就可以导向了。

### Footer

在icon内可以更改footer中间那个图标
``` Bash
# Icon between year and copyright info.
  icon:
    # Icon name in Font Awesome. See: https://fontawesome.com/icons
    name: fa fa-grip-lines-vertical
    # If you want to animate the icon, set it to true.
    animated: false
    # Change the color of icon, using Hex Code.
    color: "#999999"
```

name:可以在[fontawesome](https://fontawesome.com/icons)内选择图标，直接替换fa后的名字即可。
color:控制图标颜色，必须使用[HEX](https://www.color-hex.com/)代码。#999999与旁边字体颜色最近。

``` Bash
  # Powered by Hexo & NexT
  powered: false
```

默认为true，改为false可以把最后那个Powered by Hexo & NexT取消掉。

### Post Setting

``` Bash
# Read more button
# If true, the read more button will be displayed in excerpt section.
read_more_btn: true
```
主界面阅读全文按钮，可以在.md文件内写入 
``` Bash
<!-- more -->
```
定位按钮位置。

``` Bash
# Post meta display settings
post_meta:
  item_text: false
  created_at: true
  updated_at:
    enable: false
    another_day: false
  categories: true
```

文章标题下面的一些信息。
item_text:图标旁边是否加上文字描述
created_at:创建时间
update_at:更新时间，如果another_day为true就只显示不同日期的更改记录。

``` Bash
# Use icon instead of the symbol # to indicate the tag at the bottom of the post
tag_icon: true
```

文章最后的tags之前用小图标标记。

另外关于donate和reward的内容也在此，需要的话直接修改就行。
