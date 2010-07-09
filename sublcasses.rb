#!/usr/bin/ruby
class Top
  def initialize
    super
    @lala = 'um'
  end
  
  def to_s
    instance_variables.inspect
  end
end 


class Down < Top
  def initialize
    super
    @ondown = 'downtown'
  end

end

puts "top: " + Top.new.to_s
puts "down: " + Down.new.to_s
