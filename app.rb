## 主程序
##
## 1. 抓取股票列表
## 2. 根据股票列表向 yahoo 查询股票历史纪录
## create by xiongwei

require './class/StockListCrawler'
require './class/StockHisCrawler'

DATA_PATH = './data'

puts "抓取股票列表:"
puts "..."

stockList = StockListCrawler.new DATA_PATH
stockList.save

puts "抓取上证数据:"
stockHis = StockHisCrawler.new( './data/ss', './data/stos')
stockHis.save

puts "抓取深证数据:"
stockHis = StockHisCrawler.new( './data/sz', './data/stos')
stockHis.save
