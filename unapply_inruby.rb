#!/usr/bin/env ruby

module Enumerable
  def apply(method)
    each(&method)
  end
end

class Class
  def undef_all(enum)
    enum.each { |m| undef_method m}
  end

  def undef_all_from(clas)
    undef_all clas.public_instance_methods(false)
  end
end

class A < Array
end
a = A.new([1, 2])
puts a.method :flatten
puts "flattened #{a.flatten.inspect}"

class A < Array
  undef_all_from Array
end
x, y = a
puts "x = #{x}, y = #{y}"
#puts a.method :flatten Undefined

class Unapply < Array
  alias __toa__ <<
  Array.public_instance_methods(false).apply(method :undef_method)
end

u = Unapply.new
u.__toa__ 5
u.__toa__ 6
puts u
