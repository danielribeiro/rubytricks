#!/usr/bin/ruby
require 'set'
class Base
  attr_accessor :name

  def oi
    x = 'oi' * 2
    return x
  end
end

puts Base.new.name
