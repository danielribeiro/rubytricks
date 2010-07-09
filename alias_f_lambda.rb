#!/usr/bin/env ruby

# hinted from http://www.infoq.com/presentations/archaeopteryx-bowkett
alias l lambda

#def l (&block)
#  return block
#end

x = nil
z = l{|x| x * 2}
puts z.call 5
puts x