#!/usr/bin/env ruby
class A
  def a
    #self.b == erro
    b
  end

  private
  def b
    'b'
  end
end

puts A.new.a