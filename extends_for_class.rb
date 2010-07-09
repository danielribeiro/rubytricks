#!/usr/bin/env ruby
module ClassHi
  def hi
    'hi'
  end
end


class A
  extend ClassHi
end

puts A.hi