#!/usr/bin/env ruby
Object = Array

#Not the same as: class A
class A < Object
  
end

a = A.new
a << 1
p a