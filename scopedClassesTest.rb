#!/usr/bin/env ruby
require 'scoped_open_classes'

module MyWork
  extend SafePatcher
  patch Array do
    define :hi do
      'another hi'
    end
  end
  puts [].hi
  Work.invoke_hi []
end
#
#module InvokingAsWork
#  extend SafePatcher
#  includepatches Work
#  puts [].hi
#end

class AModule
  includepatches Work

  def invoke
    puts [].hi
  end
end

puts 'out'
AModule.new.invoke