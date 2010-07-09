#!/usr/bin/ruby
module N
  def new
    puts "mwahahha"
    super
  end

  def notdefined
    'notdefined'
  end
end

class Sup
  extend N
end 


#Sup.extend N

puts Sup.new
puts Sup.notdefined
