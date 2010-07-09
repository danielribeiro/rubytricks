#!/usr/bin/ruby
class InventoryReport < Array
  def initialize
    super()
  end
end 


class Flat < Array
  def flatten()
    return ['um', 'flat', 'flatened']
  end
end


f = Flat.new
f << ['n�o']
y = InventoryReport.new
y << [6, 8, 9]
x = InventoryReport.new
x << [1, y, 2, [5, 6], {:um => 2}, 3, f]
puts x.flatten

