#!/usr/bin/ruby
class Class
  def method_missing(m, *args, &block)
    return "There's no method called #{m} here with args #{args} and block #{block}" 
  end
end

class Sup
  def self.onclass
    return "no " + who() + lala();
  end

  def self.who
    return "Sup"
  end
end 

class Pai < Sup
  def self.who
    return "Pai"
  end  
end 

puts Pai.onclass
puts Pai.lala()
