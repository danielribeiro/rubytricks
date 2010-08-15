#!/usr/bin/env ruby
class A
  def method_missing(name, onlyone)
    [name, onlyone]
  end
end

a = A.new
p a.call :me
p a.willnotworkFor :two, :args