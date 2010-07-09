#!/usr/bin/ruby
class Sup
  def self.create(arg)
    puts "#{arg}"
  end
end 

class Pai < Sup
  create :met
end 

puts Pai.met

