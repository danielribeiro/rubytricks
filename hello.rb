#!/usr/bin/ruby
ar = [1]
y = ar.inject(6) {|x, y| x + y}
puts y
puts ar
