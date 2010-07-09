#!/usr/bin/ruby
class Top
  attr_accessor :name
  def initialize
    super
  end
end 


class Sub < Top

end

x = Top.new
puts x.instance_variables.inspect
