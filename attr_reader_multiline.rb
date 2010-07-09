#!/usr/bin/env ruby
puts "Hello World"

class Dom
  attr_writer :one,
    :two,
    :three
end

d = Dom.new
d.one = 1
d.two = 2
d.three = 3
puts d.inspect