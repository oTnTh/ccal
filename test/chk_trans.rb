# coding: UTF-8
# 检验移植自“寿星天文历”的代码是否工作正常，需要预先准备“寿星天文历”输出的JSON文件

FILE_DIR = File.dirname(File.expand_path(__FILE__))
require File.join(FILE_DIR, '../lib/ccal.rb')
require 'date'
require 'json'

ary = JSON.parse(File.open(File.join(FILE_DIR, 'json.txt'), 'r:utf-8').read)
yb = -4712
ye = -4100
yb.upto(ye) do |y|
  jd = Date.civil(y).jd - CCal::Gol_Eph::J2000

  m = CCal::Gol_Eph.calc_y(jd)
  m['zq'].delete('pe1'); m['zq'].delete('pe2')
  m['zq'] = m['zq'].values.to_a

  t = ary[y-yb]

  # 这么比对非常耗时，1分钟500年的样子
  s = ''
  m.each do |k, v|
    if v != t[k] then
      if v === Array then
        s += "\n\t#{k.to_s}: #{(t[k]-v).to_s} => #{(v-t[k]).to_s}"
      else
        s += "\n\t#{k.to_s}: #{t[k].to_s} => #{v.to_s}"
      end
    end
  end

  if s != '' then
    puts "#{y}:" + s + "\n"
  end
end
