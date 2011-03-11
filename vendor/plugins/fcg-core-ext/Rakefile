require 'rubygems'
require 'rake'
require 'lib/fcg-core-ext/version.rb'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "fcg-core-ext"
    gem.summary = 'FCG Core Extensions'
    gem.description = 'Ruby classes and methods altered'
    gem.email = "sam@fcgmedia.com"
    gem.homepage = "http://github.com/joemocha/fcg-core-ext"
    gem.authors = ["Samuel O. Obukwelu"]
    gem.add_development_dependency "thoughtbot-shoulda", ">= 2.11.1"
    gem.add_dependency 'andand', '>= 1.3.1'
    gem.add_dependency 'yajl-ruby'
    gem.add_dependency 'hashie', '>= 0.4.0'
    gem.add_dependency 'msgpack', '>= 0.4.3'
    gem.add_dependency 'facets', '>= 2.8.4'
    gem.add_dependency 'thor', '>= 0.14.3'
    
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
    gem.version = FcgCoreExt::VERSION
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "fcg-core-ext #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
