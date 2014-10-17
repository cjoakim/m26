=begin

Copyright (C) 2014 Chris Joakim, JoakimSoftware LLC

=end

require 'rubygems'
require 'rake'
require 'rbconfig'
require 'rdoc/task'
require 'rspec/core/rake_task'
require 'fileutils'
require 'rake/testtask'

$: << "."
$:.unshift File.join(File.dirname(__FILE__), "", "lib")
Dir[File.join(File.dirname(__FILE__),'lib/tasks/*.rake')].each { | file | load file }

require 'm26'

desc "Default Task; rake spec"
task :default => [ 'spec'.to_sym ]

Rake::RDocTask.new do | t |
  t.main  = "README.rdoc"
  t.title = "m26"
  t.rdoc_files.include("README.rdoc", "lib/**/*.rb")
end

Rake::TestTask.new do | t |
  t.libs.push "lib"
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

namespace :test do
  desc "Executes the 'test' task after deleting the previous coverage result files."
  task :clean do
    FileUtils.rm_r 'coverage', :force => true
    Rake::Task["test"].execute
  end
end

RSpec::Core::RakeTask.new('spec')
