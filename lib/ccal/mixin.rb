# coding: UTF-8
require 'date'

module CCal
  module Mixin
    private

    # 计算农历数据
    def method_missing(sym, *args)
      cday = CCal::CDate.calc_day(self.to_datetime.jd)
      cday.each do |sym, value|
        define_singleton_method(sym){return value}
      end
      
      cday.has_key?(sym) ? send(sym, *args) : super
    end

    public

    # 格式化输出
    #
    # 参数：
    #
    # * %G - 天干纪年
    # * %Z - 地支纪年
    # * %X - 生肖
    # * %Y - 月
    # * %T - 月大/小
    # * %R - 日
    # * %Q - 节气
    #
    def cstrftime(fmt = nil)
      if not fmt then
        fmt = '%G%Z年（%X）%Y月（%T）%R'
        fmt += '（%Q）' if @term
      end
      s = fmt
      s.gsub!(/%G/, self.stem) # 天干纪年
      s.gsub!(/%Z/, self.branch) # 地支纪年
      s.gsub!(/%X/, self.animal) # 生肖
      s.gsub!(/%Y/, self.cmonth) # 月
      s.gsub!(/%T/, @cmdays == 30 ? '大' : '小')
      s.gsub!(/%R/, self.cday) # 日
      s.gsub!(/%Q/, self.term) # 节气
      return s
    end

  end
end

class Time
  include CCal::Mixin

  def self.from_ccal(cyear, cmonth, cday)
    d = CCal::CDate.from_ccal(cyear, cmonth, cday)
    return Time.new(*d)
  end
end

class Date
  include CCal::Mixin

  def self.from_ccal(cyear, cmonth, cday)
    d = CCal::CDate.from_ccal(cyear, cmonth, cday)
    return Date.civil(*d)
  end
end

class DateTime
  include CCal::Mixin

  def self.from_ccal(cyear, cmonth, cday)
    d = CCal::CDate.from_ccal(cyear, cmonth, cday)
    return DateTime.civil(*d)
  end
end
