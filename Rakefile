require 'bundler'
require 'rake/testtask'

Bundler::GemHelper.install_tasks

task :default => :test
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib' << 'test'
  t.pattern = 'test/**/*_test.rb'
end
