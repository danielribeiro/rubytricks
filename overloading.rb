#!/usr/bin/ruby
class Const
  def initialize(newname)
    @name = newname
  end
 
  def name
    @name
  end

end 

x = Const.new('lala')
puts x.name
