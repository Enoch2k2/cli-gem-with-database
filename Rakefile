ENV["SINATRA_ENV"] ||= "development"
require "bundler/gem_tasks"
require "rspec/core/rake_task"

require_relative './lib/environment'
require 'sinatra/activerecord/rake'

# Type `rake -T` on your command line to see the available rake tasks.

task :console do
  Pry.start
end

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

