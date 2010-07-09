#!/usr/bin/env ruby
require 'pp'
module Kernel
  def method_missing(name, *args)
    return [name] if args.empty?
    [name].push *args.first
  end
end

x = 'oi'
def x.canta
  'x cantar'
end
puts x.canta
pp the book is on the table

def um
  dois
end

def dois
  tres
end

def tres
  raise 'In htere'
end
#
#begin
#  um
#rescue Exception => ex
#  puts ex.backtrace.class
#end
