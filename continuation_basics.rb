#!/usr/bin/env ruby

def continuation
  puts "Before callcc"
  out = callcc {|lola| puts "In callcc #{lola}" ; lola}
  puts "return of cont: #{out}"
  puts "After callcc"
end

puts "Begin"
cont = continuation()
puts "Got cont #{cont.inspect}"
if cont
  cont.call('argument passed to callcc')
  puts "After call"
else
  puts "!!! is NIL. We jumped back in time!"
end
puts "All done"
