#!/usr/bin/ruby
def acum(n)
  proc {|i| n += i}
end

# acum = proc {|n| 
#   proc {|i| n += i}}


lisp = acum(9)
puts(lisp.call(0))
puts(lisp.call(1))
