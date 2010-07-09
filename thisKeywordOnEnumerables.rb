#!/usr/bin/env ruby
class Array
  @@original_map = instance_method(:map)
  def map(&block)
    return @@original_map.bind(self).call(&block) if block.arity == 1
    @arg = nil
    @@original_map.bind(self).call do |v|
      @arg = v
      instance_eval(&block)
    end
  end

  def selectit(&block)
    
  end

  def it
    @arg
  end
end

#out = %w[the book is on the table].map { |l| l.length }
out = %w[the book is on the table].map { it.length }
puts "out is #{out.inspect}"