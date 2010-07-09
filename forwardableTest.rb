#!/usr/bin/env ruby
require 'forwardable'

class F
  extend Forwardable
  def_delegator :self, :size, :length

  def size
    0
  end
end

x = F.new
puts x.length
puts x.size