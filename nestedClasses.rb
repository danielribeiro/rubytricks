#!/usr/bin/env ruby
class B
  class A
    def oi
      'oi'
    end
  end

  def a
    A.new
  end
end

puts B.new.a.oi