## 历史纪录抓取器
## 通过 yahoo api 获取
## create by xiongwei

require 'net/http'

class StockHisCrawler
    # 抓取地址
    Url = "http://table.finance.yahoo.com/table.csv"

    def initialize(filepath, path='.', y='2015', m='0', d='1')
        @filepath = filepath
        @path = path
        @year = y
        @month = m
        @day = d
        @stosArr = []
    end

    # 保存股票历史到文件
    def save
        self.readToArray

        @stosArr.map do |sto|
            uri = URI(Url + "?s=" + sto + "&c=" + @year + "&a=" + @month + "&b=" + @day + "&ignore=.csv")
            puts uri

            begin
                sto_his = Net::HTTP.get(uri)
            rescue => ex
                puts ex.message
                puts '等待10s后重试'
                sleep 10
                retry
            end

            file = @path + '/' + sto
            begin
                io = open(file, 'w+')
                io.puts(sto_his)
                io.close
                puts file + ' is saved'
            rescue Errno::ENOENT
                Dir.mkdir(@path)
                retry
            end

        end
    end

    # 读取文件生成数组
    def readToArray
        stos = open @filepath
        stos.each_line do |line|
            sto = line.split(',')
            sto = sto[1] + '.' + sto[2].chomp
            @stosArr.push sto
        end
    end

end
