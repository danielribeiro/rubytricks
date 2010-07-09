#!/usr/bin/ruby
class Over
   def self.new
    return "not instance of over"
  end

  def self.create(*args, &block)
    obj = self.allocate
    obj.send :initialize, *args, &block
    obj
  end

  def to_s
    "an instance of over: #{self.class}"
  end
end

puts Over.new
puts Over.create


class Class
  alias oldnew new
end

class Over2
   def self.new
    return "not instance of over2"
  end

  def self.create(*args, &block)
    return oldnew
  end

  def to_s
    "an instance of over2: #{self.class}"
  end
end

puts Over2.new
puts Over2.create
