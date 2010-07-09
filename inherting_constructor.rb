#!/usr/bin/env ruby
#does inherit

class A
  attr_reader :value


  def initialize(value)
    @value = value
  end
end

class B < A
  
end

puts A.new(5).value
puts B.new(6).value