#!/usr/bin/env ruby
require 'pp'



def tohex(str)
  return str.chars.each_slice(2).map {|x, y| (x + y).to_i(16)}
end
for line in STDIN:
    r, g, b = tohex(line.strip)
    puts "##{line.strip} = (#{r}, #{g}, #{b})"
end