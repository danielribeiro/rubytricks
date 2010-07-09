#!/usr/bin/env ruby
def call(name, arg = 'x', o = 'y')
  puts "#{name}, #{arg}, #{o}"
end

call :self, o = 'alfa'