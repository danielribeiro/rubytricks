#!/usr/bin/env ruby
def printArgs(arg)
  p arg
end
numbers = ['one', 'two', 'three']
printArgs numbers.map do |i|
  i.size
end

puts "with curlies"
printArgs numbers.map { |i|
  i.size
}

puts "now with variables"

x =  numbers.map do |i|
  i.size
end
p x

puts "with curlies and variables"
y = numbers.map { |i|
  i.size
}
p y