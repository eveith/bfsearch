require 'rdoc/task'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
end

RDoc::Task.new do |rdoc|
  rdoc.main = 'README.md'
  rdoc.rdoc_files.include('README.md', 'lib/**/*.rb')
end

desc "Run tests"
task :default => :test
