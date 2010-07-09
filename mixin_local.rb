#!/usr/bin/env ruby
module Hier
  def oi
    puts 'oi'
  end
end

class A
  def bye
    puts 'bye'
  end
end

x = A.new.extend Hier
x.oi
x = {}
x.default(5)