#!/usr/bin/env ruby

def procnew
  f = Proc.new { return "return from foo from inside proc" }
  f.call # control leaves foo here
  return "return from #{__method__}"
end

def lambdacall
  f = lambda { return "inner return from #{__method__}" }
  f.call # control does not leave bar here
  return "return from #{__method__}"
end

def procinvoke
  f = proc { return "inner return from #{__method__}" }
  f.call # control does not leave bar here
  return "return from #{__method__}"
end

def fromyield(&block)
  yield
  return "return from #{__method__}"
end

def calling(name, func)
  puts "calling: #{name}"
  func.call
  return "return from #{__method__}: #{name}"
end

def d(&block)
  begin
    puts yield
  rescue Exception => ex
    puts "! error: #{ex}"
  end

end

#d { procnew } # prints "return from foo from inside proc"
#d { lambdacall } # prints "return from bar"
#d { procinvoke }
bl  = lambda do
  return "return from foo from inside proc"
end
d { calling(:lambda, lambda { return "return from foo from inside proc" }) }
#d { calling(:proc, proc { return "return from foo from inside proc" })}

def outofhere
  puts "getting out of here"
  d { calling(:procnew, Proc.new { return "return from foo from inside proc" })}
  d { fromyield { return 'outter '} }# throws exception
end

#outofhere
