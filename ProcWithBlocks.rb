#!/usr/bin/env ruby
class ProcWithBlock < Proc
  def self.new(*args, &block)
    return super {}
  end

  def call(*args, &block)
    puts "invoked with args #{args}"
    puts "the block invoked with the args returns:"
    puts block.call *args
    puts "self calld with the args returns"
  end
end

x = ProcWithBlock.new.call(1, 2) do |x, y|
  x + y
end