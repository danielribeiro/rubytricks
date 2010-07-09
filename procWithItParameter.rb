#!/usr/bin/env ruby

class ProcWrapper
  def initialize(&pr)
    @pr = pr
  end

  def to_proc
    proc { |x|
      @var = x
      puts "got #{x}"
      instance_eval &(@pr)
    }
  end

  def it
    @var
  end
end

def L(&block)
  ProcWrapper.new &block
end

out = %w[the book is on the table].map (L{ it * 2 })
out = %w[the book is on the table].map {|i| i * 2}
puts "out is #{out.inspect}"