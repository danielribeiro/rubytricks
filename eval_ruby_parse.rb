#!/usr/bin/ruby -rubygems
require 'rubygems'

require 'ruby_parser'
require 'pp'
require 'ruby2ruby'

ruby2ruby = Ruby2Ruby.new


class Fixnum
  def callWithDot(*arg)
    puts "called with dot: #{arg}"
    return *arg[0]
  end
end

def conditional1(arg1)
  if arg1
      return 1
  end
  return 0
end
code1 = "
  def conditional1(arg1)
    if arg1.callWithDot: 5 == 0
      return 1
    end
    return 0
  end
"

code = "
  def conditional1(arg1)
    if arg1.callWithDot 5 == 0
      return 1
    end
    return 0
  end
"
parser = RubyParser.new

pp(parser.parse code)
pp(parser.parse code1)

puts ruby2ruby.process(parser.parse code)
puts ruby2ruby.process(parser.parse code1)
