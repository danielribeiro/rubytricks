#!/usr/bin/env ruby
class P
  def method_missing(name, *args)
    puts "tried invoking #{name} with #{args}"
  end
end


P.new.send :invoca, 'oi'