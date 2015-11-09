# stocks-crawler
基于 ruby 的爬虫程序，爬取 yahoo 提供的股票历史数据。
主要爬取上证、深证数据

## 安装依赖和运行

[Nokogiri](https://github.com/sparklemotion/nokogiri)

    gem install nokogiri

运行

    ruby app.rb

## 说明

config.yml 为配置文件，详情见文件备注

上证、深证的股票名单来自[东方财富网](http://www.eastmoney.com)。

* 名单保存路径为 ./data 目录（目录可自行设置）
* 上证名单保存为 ss 文件
* 深证名单保存为 sz 文件。

获取名单后，从 yahoo 抓取个股历史记录。保存路径为 ./data/sto 目录。

* 上证个股保存文件名是 "股票代码.ss"
* 深证个股保存文件名是 "股票代码.sz"
* 另，指数保存路径为 ./data/index-out 路径
