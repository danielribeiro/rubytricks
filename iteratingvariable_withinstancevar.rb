#!/usr/bin/env ruby
def double(x)
   x * 2
end

class Object
  def dobra
    return self * 2
  end

  def it
    self
  end
end

def prime(arg)
  puts arg
  return nil
end


class Array
  def itmap(&block)
    ret = []
    for i in self
      ret << i.instance_eval(&block)
    end
    return ret
  end
end

class Breaker
  def breakit
    p [1, 2, 3].itmap { double(it) }
  end

  def double(x)
    "double it #{x}"
  end


end

p ['1', '2', '3'].itmap { it.dobra }
p ['1', '2', '3'].itmap { prime(it)}
p [1, 2, 3].itmap { it.dobra }
p [1, 2, 3].itmap { double(it)}
Breaker.new.breakit