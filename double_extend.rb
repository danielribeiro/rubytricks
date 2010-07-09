#!/usr/bin/env ruby
module A
  def a
    'a'
  end
end


module B
  extend A
  def b
    'b'
  end
  puts a
end

module C
  extend B
  def c
    'c'
  end
  puts b
end

module Teste
  extend C
  puts c

end

puts "!! fora"
puts C.methods