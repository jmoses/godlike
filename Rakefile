require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the godlike plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "flexible-godlike"
    gemspec.summary = "Feel godly after your tests"
    gemspec.description = "Announcers can be motivating. \n  Forked from a fork from a fork....Follow the github chain for more."
    gemspec.email = "jon@burningbush.us"
    gemspec.homepage = "http://github.com/jmoses/godlike"
    gemspec.authors = ["Jon Moses"]
    Jeweler::GemcutterTasks.new
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end