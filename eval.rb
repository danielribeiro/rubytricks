#!/usr/bin/ruby
def evalAndReturn(n)
#  eval "x = #{n}"
  x = n
  puts x
  return [n] * 5
end


# puts x
k = evalAndReturn(5)
puts "k = #{k}"
