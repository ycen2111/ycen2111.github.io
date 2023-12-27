---
title: Hexo个人博客创建引导（三）
date: 2021-09-10 10:01:01
tags:
- 编程
- Blog
categories:
- Hexo模板
---

## 插件介绍

如果一些功能没有包含在主题内或想使用自己的内容，可以在官网的[插件库](https://hexo.io/plugins/)内下载使用。一些常用的插件会时不时更新在此页面。
<!-- more -->

## 搜索功能插件

在主要小图标的最右侧增加一个搜索按钮。

在工程更根目录输入
``` Bash
npm install hexo-generator-searchdb --save
```

全局配置文件内加入
``` Bash
#Search
search:
  path: search.xml
  field: post
  format: html
  limit: 10000
```

theme配置文件寻找“Local Search”修改
``` Bash
# Local Search
# Dependencies: https://github.com/next-theme/hexo-generator-searchdb
local_search:
  enable: true
```

## 插入图片插件

支持在Blog里放入图片。

在工程更根目录输入
``` Bash
npm install hexo-asset-image --save
```

全局配置文件内修改
``` Bash
post_asset_folder: true
```

找到“/node_module/hexo-asset-image/index.js”, 替换内容为
``` Bash
'use strict';
var cheerio = require('cheerio');

// http://stackoverflow.com/questions/14480345/how-to-get-the-nth-occurrence-in-a-string
function getPosition(str, m, i) {
  return str.split(m, i).join(m).length;
}

var version = String(hexo.version).split('.');
hexo.extend.filter.register('after_post_render', function(data){
  var config = hexo.config;
  if(config.post_asset_folder){
        var link = data.permalink;
    if(version.length > 0 && Number(version[0]) == 3)
       var beginPos = getPosition(link, '/', 1) + 1;
    else
       var beginPos = getPosition(link, '/', 3) + 1;
    // In hexo 3.1.1, the permalink of "about" page is like ".../about/index.html".
    var endPos = link.lastIndexOf('/') + 1;
    link = link.substring(beginPos, endPos);

    var toprocess = ['excerpt', 'more', 'content'];
    for(var i = 0; i < toprocess.length; i++){
      var key = toprocess[i];
 
      var $ = cheerio.load(data[key], {
        ignoreWhitespace: false,
        xmlMode: false,
        lowerCaseTags: false,
        decodeEntities: false
      });

      $('img').each(function(){
        if ($(this).attr('src')){
            // For windows style path, we replace '\' to '/'.
            var src = $(this).attr('src').replace('\\', '/');
            if(!/http[s]*.*|\/\/.*/.test(src) &&
               !/^\s*\//.test(src)) {
              // For "about" page, the first part of "src" can't be removed.
              // In addition, to support multi-level local directory.
              var linkArray = link.split('/').filter(function(elem){
                return elem != '';
              });
              var srcArray = src.split('/').filter(function(elem){
                return elem != '' && elem != '.';
              });
              if(srcArray.length > 1)
                srcArray.shift();
              src = srcArray.join('/');
              $(this).attr('src', config.root + link + src);
              console.info&&console.info("update link as:-->"+config.root + link + src);
            }
        }else{
            console.info&&console.info("no src attr, skipped...");
            console.info&&console.info($(this));
        }
      });
      data[key] = $.html();
    }
  }
});
```
[原地址在此](https://blog.csnd.net/xjm850552586)，赞美大佬！

之后每次新建new page都会额外生成一个同名文件夹，把需要的图片放进去后在.md文件内输入
``` Bash
![ImageDescription](ImageName.npg)
```

就可以显示图片了。

## 插入本地音乐播放器
(https://github.com/MoePlayer/hexo-tag-aplayer/blob/master/docs/README-zh_cn.md#%E6%92%AD%E6%94%BE%E5%88%97%E8%A1%A8)
支持在Blog里放入音乐。

在工程更根目录输入
``` Bash
npm install --save hexo-tag-aplayer
```
全局配置文件内修改
``` Bash
post_asset_folder: true
```
在.md文件内输入
``` Bash
{% aplayer title author url [picture_url, narrow, autoplay, width:xxx, lrc:xxx] %}
```
例如
``` Bash
{% aplayer "Caffeine" "Jeff Williams" "caffeine.mp3" "picture.jpg" "lrc:caffeine.txt" %}
```


## 文章密码插件

如果想加密某些文件，可以添加这个插件。

下载plugin
``` Bash
npm install --save hexo-blog-encrypt
```

在根目录配置文件添加
``` Bash
# Security
encrypt: # hexo-blog-encrypt
  abstract: Here's something encrypted, password is required to continue reading.
  message: Hey, password is required here.
  tags:
  - {name: encryptAsDiary, password: passwordA}
  - {name: encryptAsTips, password: passwordB}
  theme: up
  wrong_pass_message: Oh, this is an invalid password. Check and try again, please.
  wrong_hash_message: Oh, these decrypted content cannot be verified, but you can still have a look.
```

theme: 密码输入界面样式，可查看[作者实例](https://mhexo.github.io/2020/12/23/Theme-Test-Default/)。

之后只要在文章配置内加入password
``` Bash
title: Hello World
date: 2020-03-13 21:12:21
password: hello
---
```

文章底有encrypt again按钮，可重置密码记忆记录。

## 插入PDF插件

可以插入一个pdf阅读框

下载plugin
``` Bash
$ npm install --save hexo-pdf
```

打开hexo configuration，修改
``` Bash
# PDF tag
# NexT will try to load pdf files natively, if failed, pdf.js will be used.
# So, you have to install the dependency of pdf.js if you want to use pdf tag and make it available to all browsers.
# Dependencies: https://github.com/next-theme/theme-next-pdf
pdf:
  enable: true
  # Default height
  height: 500px
```

如果需要插入pdf，在.md同目录新建一个同名文件夹，放入pdf文件，输入
``` Bash
{% pdf  pfdName.pdf %} 
```

插入PDF