#!/usr/bin/env ruby

# doesn' happen
class A
  def method_missing(name, *args, &block)
    puts "method #{name}, #{args.inspect} invoked"
  end
end

m = A.instance_method(:call)
puts m