## 主程序
##
## 1. 抓取股票列表
## 2. 根据股票列表向 yahoo 查询股票历史纪录
## create by xiongwei

require 'yaml'

require './class/StockListCrawler'
require './class/StockHisCrawler'

puts "初始化"
puts "..."
config = YAML.load_file('./config.yml')
DATA_PATH = config['data-path']
START_TIME = Time.now - config['day']*60*60*24
YEAR =  START_TIME.year.to_s
MONTH = (START_TIME.month-1).to_s
DAY = START_TIME.day.to_s
puts "ok"
puts "-----------------------"

puts "抓取股指数数据:"
puts "..."
begin
  io = open("#{DATA_PATH}/index", 'w+')
  io.puts(config['index-ss'])
  io.puts(config['index-sz'])
  io.close
rescue Erron::ENOENT
  Dir.mkdir(DATA_PATH)
  retry
end
stockHis = StockHisCrawler.new( "#{DATA_PATH}/index", "#{DATA_PATH}/index-out", YEAR, MONTH, DAY)
stockHis.save
puts "done"
puts "-----------------------"

puts "抓取股票列表:"
puts "..."
stockList = StockListCrawler.new DATA_PATH
stockList.save
puts "done"
puts "-----------------------"

puts "抓取上证数据:"
stockHis = StockHisCrawler.new( "#{DATA_PATH}/ss", "#{DATA_PATH}/stos", YEAR, MONTH, DAY)
stockHis.save
puts "done"
puts "-----------------------"

puts "抓取深证数据:"
stockHis = StockHisCrawler.new( "#{DATA_PATH}/sz", "#{DATA_PATH}/stos", YEAR, MONTH, DAY)
stockHis.save
puts "done"
puts "-----------------------"
puts "over"
