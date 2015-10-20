## 主程序
##
## 1. 抓取股票列表
## 2. 根据股票列表向 yahoo 查询股票历史纪录
## create by xiongwei

require './class/StockListCrawler'
require './class/StockHisCrawler'

DATA_PATH = './data'
START_TIME = Time.now - 1000000
YEAR =  START_TIME.year.to_s
MONTH = (START_TIME.month-1).to_s
DAY = START_TIME.day.to_s


puts "抓取股票列表:"
puts "..."

stockList = StockListCrawler.new DATA_PATH
stockList.save

puts "抓取上证数据:"
stockHis = StockHisCrawler.new( './data/ss', './data/stos', YEAR, MONTH, DAY)
stockHis.save

puts "抓取深证数据:"
stockHis = StockHisCrawler.new( './data/sz', './data/stos', YEAR, MONTH, DAY)
stockHis.save
