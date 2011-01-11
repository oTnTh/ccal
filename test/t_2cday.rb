# coding: UTF-8

FILE_DIR = File.dirname(File.expand_path(__FILE__))
$:.push File.join(FILE_DIR, '../lib')
require 'ccal'

if ARGV.length == 0 then
  puts Time.now.cstrftime.encode(Encoding.default_external)
else
  puts DateTime.parse(ARGV[0]).cstrftime.encode(Encoding.default_external)
end
