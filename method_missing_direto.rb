#!/usr/bin/env ruby
class A
  def method_missing(name, *args, &block)
    puts "callled #{name} with #{args} and a block #{block_given?}?"
  end
end

x = A.new
x.method_missing("ok", 'oi') {}