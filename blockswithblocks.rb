#!/usr/bin/env ruby
#not possible in 1.8: http://stackoverflow.com/questions/89650/how-do-you-pass-arguments-to-definemethod
b = lambda do |*args|
  puts args
end

b.call(6, 7, 89, lambda { puts 'done'}, lambda { puts 'and done'})