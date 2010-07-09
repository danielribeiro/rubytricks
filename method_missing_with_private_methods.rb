#!/usr/bin/env ruby
class A
  def method_missing(name, *args, &block)
    "inovked #{name} with '#{args}'"
  end

  private
  def oi
    'oi'
  end
end

puts A.new.oi