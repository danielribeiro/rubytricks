#!/usr/bin/ruby
ar = [1, 2]
y = [3, 5, ar]
ar << y
puts y
puts y.flatten
