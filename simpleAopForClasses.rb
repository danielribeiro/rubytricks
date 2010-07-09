#!/usr/bin/env ruby
class Module
    public :include
end

class Object
  def metaclass
    class << self; self; end
  end
end

module MyClassMethods
  def hi
    'class hi'
  end
end


class A
  def self.hi
    'hi'
  end
end

module PreHi
  def hi
    puts "pre hi... i am #{self}"
    super
  end
end


#A.extend PreHi #same as A.metaclass.include PreHi
A.extend PreHi

puts A.metaclass.ancestors
puts A.hi