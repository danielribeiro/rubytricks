#!/usr/bin/env ruby
# actually is not
class A
  def x
    'x'
  end
end


class Method
  attr_accessor :anon
end

a = A.new
m = a.method :x
m.anon = :overloaded
m2 = a.method :x
puts m.anon
puts m2.anon
puts m2.instance_variables.inspect