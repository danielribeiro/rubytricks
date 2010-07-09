#!/usr/bin/ruby
class Sup
  def self.yell
    return 'at sup: ' + override
  end

  def self.override
    return ' override at sup'
  end
end 

class Inf < Sup
  def self.override
    return ' override at inf'
  end
end

puts Sup.yell
puts Inf.yell
