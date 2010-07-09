#!/usr/bin/env ruby
puts "Hello World"

def square(x)
  x * x
end

puts (1..9).map(&method(:square))