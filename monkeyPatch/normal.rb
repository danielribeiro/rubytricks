#!/usr/bin/ruby

class Monkey
  def div(n)
    return 5 / n
  end
end

puts Monkey.new.div(0)