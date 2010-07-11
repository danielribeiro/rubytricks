#!/usr/bin/env ruby
module M
  def mm
    'mm'
  end

end

module N
  def nn
    'nn'
  end

  def self.included(m)
    return unless m.class == Module
    for c in ObjectSpace.each_object(Class)
      A.send :include, self if c.include? m
    end
  end
end


# Doesn't work here withouth the self.included
class A
  include M
end


module M
  include N
end


puts A.new.mm
puts A.new.nn