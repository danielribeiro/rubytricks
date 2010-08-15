#!/usr/bin/env ruby
class A
  def doself
    (1..10).map do |i|
      self
    end
  end
end

p A.new.doself