#!/usr/bin/env ruby
class A
  def hi
    'hi'
  end
end

A.class_eval {
  def oi
    'oi'
  end
}

A.instance_eval {
  def lala
    'lala'
  end
}


puts A.new.hi
puts A.new.oii
puts A.lala