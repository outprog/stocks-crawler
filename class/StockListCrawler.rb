## 股票列表抓取器
## 通过天天基金网获取股票列表
## create by xiongwei

require 'open-uri'
require 'nokogiri'

class StockListCrawler
    # 抓取地址
    Url = 'http://quote.eastmoney.com/stock_list.html'

    def initialize(path='.')
        begin
          ## 该网页编码不为 utf-8
          html = open( Url).read.force_encoding("GBK")
          @doc = Nokogiri::HTML(html)
        rescue => ex
          puts ex.message
          puts "等待十秒后重试"
          sleep 10
          retry
        end
        @path = path
    end

    # 上证
    def getss
        get(0, 'ss')
    end

    # 深证
    def getsz
        get(1, 'sz')
    end

    def get(n, type)
        @doc.css('#quotesearch ul')[n].css('a').map{ |sto| sto.text.gsub('(', ',').gsub(')', ",#{type}") }
    end

    # 存储
    def save
        saveToFile('ss', self.getss)
        saveToFile('sz', self.getsz)
    end

    def saveToFile(filename, content)
        file = @path + '/' + filename
        begin
            io = open(file, 'w+')
            io.puts(content)
            io.close
            puts file + ' is saved'
        rescue Errno::ENOENT
            Dir.mkdir(@path)
            retry
        end
    end
end
