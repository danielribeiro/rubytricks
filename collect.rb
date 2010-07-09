#!/usr/bin/ruby
l = [1, 2, 3].collect { |x|
  'written ' * x
  return;
}

puts l.inspect
