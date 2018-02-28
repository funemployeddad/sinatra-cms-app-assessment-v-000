ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

def reload!
  load_all "./config" if Dir.exists?("./config")
  load_all "./app" if Dir.exists?("./app")
  load_all "./lib" if Dir.exists?("./lib")
  load_all "./*.rb" if Dir.entries(".").include?(/\rb/)
end

task :console do
  puts "Loading your environment"
  reload!
  puts "Console started"
  Pry.start
end
