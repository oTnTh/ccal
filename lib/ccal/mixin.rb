# coding: UTF-8
require 'date'

module CCal
  # 本模块将被Time和Date类包含以提供农历功能
  module Mixin
    @cinited = false

    private
    # 计算农历数据
    def cinit
      return if @cinited

      cday = CCal::CDate.day(self.to_datetime.jd)
      @stem = cday[:stem]
      @branch = cday[:branch]
      @animal = cday[:animal]
      @cmonth = cday[:cmonth]
      @cmleap = cday[:cmleap]
      @cmdays = cday[:cmdays]
      @cday = cday[:cday]
      @term = cday[:term]
      @astrology = cday[:astrology]

      @cinited = true
    end

    public

    # 农历月名
    def cmonth
      cinit
      return (@cmleap ? CDate.leap : '') + CDate.months[@cmonth]
    end

    # 农历日名
    def cday
      cinit
      return CDate.days[@cday]
    end

    # 天干纪年
    def stem
      cinit
      return CDate.stems[@stem]
    end

    # 地支纪年
    def branch
      cinit
      return CDate.branches[@branch]
    end

    # 生肖
    def animal
      cinit
      return CDate.animals[@animal]
    end

    # 节气
    def term
      cinit
      return @term == -1 ? '' : CDate.terms[@term]
    end

    # 格式化输出
    #
    # 参数：
    #
    # * %G - 天干纪年
    # * %Z - 地支纪年
    # * %X - 生肖
    # * %Y - 月
    # * %D - 月大/小
    # * %R - 日
    # * %Q - 节气
    #
    def cstrftime(fmt = nil)
      cinit
      if not fmt then
        fmt = '%G%Z年（%X）%Y月（%D）%R'
        fmt += '（%Q）' if @term != -1
      end
      s = fmt
      s.gsub!(/%G/, self.stem) # 天干纪年
      s.gsub!(/%Z/, self.branch) # 地支纪年
      s.gsub!(/%X/, self.animal) # 生肖
      s.gsub!(/%Y/, self.cmonth) # 月
      s.gsub!(/%D/, @cmdays == 30 ? '大' : '小')
      s.gsub!(/%R/, self.cday) # 日
      s.gsub!(/%Q/, self.term) # 节气
      return s
    end
  end
end

class Time
  include CCal::Mixin
end

class Date
  include CCal::Mixin
end

class DateTime
  include CCal::Mixin
end
