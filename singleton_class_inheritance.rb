#!/usr/bin/env ruby
class Object
  def metaclass
    class << self; self; end
  end
end


class A
  def self.meta
    'A'
  end
  private_class_method :meta
  
end

class B < A
  def self.metab
    'B:' + meta
  end
end

puts B.metab