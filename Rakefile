# coding: utf-8

FILE_DIR = File.dirname(File.expand_path(__FILE__))
$:.push File.join(FILE_DIR, 'lib')
require 'ccal/version'
require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/testtask'

spec = Gem::Specification.new do |s|
  s.name = 'ccal'
  s.version = CCal::VERSION
  s.has_rdoc = true
  s.extra_rdoc_files = ['BKGINFO.rdoc', 'README.rdoc', 'CHANGE.rdoc', 'COPYING.rdoc']
  s.summary = 'Chinese Lunisolar Calendar for Ruby'
  s.description = s.summary
  s.author = 'oCameLo'
  s.email = ''
  s.homepage = 'https://github.com/oTnTh/ccal'
  # s.executables = ['your_executable_here']
  s.files = %w(BKGINFO.rdoc BSDL CHANGE.rdoc COPYING.rdoc Rakefile README.rdoc) + Dir.glob("{bin,lib,test}/**/*")
  s.require_path = "lib"
  s.bindir = "bin"
end

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = true
  p.need_zip = true
end

Rake::RDocTask.new do |rdoc|
  files =['BKGINFO.rdoc', 'README.rdoc', 'CHANGE.rdoc', 'COPYING.rdoc', 'lib/**/*.rb']
  rdoc.rdoc_files.add(files)
  rdoc.main = "README.rdoc" # page to start on
  rdoc.title = "CCal Docs"
  rdoc.rdoc_dir = 'doc' # rdoc output folder
  rdoc.options << '--line-numbers'
end

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/t_*.rb']
end
