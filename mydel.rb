#!/usr/bin/env ruby
require 'rubilicious'
require 'yaml'
File.open('mydel.txt', 'w') do |file|
  YAML.dump(Rubilicious.new('danrbr', 'notachance').all, file)
end
puts "done"