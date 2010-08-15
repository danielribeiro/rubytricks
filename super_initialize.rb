#!/usr/bin/env ruby
class A
  def initialize
    puts 'not invoked'
  end
end

class B < A
  def initialize
#    super needs to be invoked explicitily
    puts 'this is not java'
  end
end

B.new