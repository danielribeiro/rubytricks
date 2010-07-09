#!/usr/bin/env ruby
require 'pp'

module A
  def oi
    'oi'
  end
end

pp Enumerable.ancestors
module Enumerable
  def insertInto(array, &block)
    each do |i|
      array << block.call(i)
    end
    array
  end
  self.send :include, A
end

x = (1..9).to_a
y = %w[um dois tres quatro]
pp y.class.ancestors
#puts y.insertInto(x, &:size)
pp Enumerable.ancestors