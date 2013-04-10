#!/usr/bin/env ruby
def procnew
  f = Proc.new { return "return from foo from inside proc" }
  f.call # control leaves procnew here
  puts "after f.call on #{__method__}"
  return "return from #{__method__}"
end

def lambdacall
  f = lambda { return "inner return from #{__method__}" }
  f.call # control does NOT leave lambdacall here
  puts "after f.call on #{__method__}"
  return "return from #{__method__}"
end

def procinvoke
  f = proc { return "inner return from #{__method__}" }
  f.call # control leaves procinvoke here
  puts "after f.call on #{__method__}"
  return "return from #{__method__}"
end

def fromyield(&block)
  yield
  puts "after f.call on #{__method__}"
  return "return from #{__method__}"
end

def calling(name, f)
  puts "calling: #{name}"
  f.call
  puts "after f.call on #{__method__}"
  return "return from #{__method__}: #{name}"
end

def d(&block)
  begin
    puts yield
    puts ""
  rescue Exception => ex
    puts "! error: #{ex}"
  end

end

d { procnew } # prints "return from foo from inside proc"
d { lambdacall } # prints "return from lambdacall"
d { procinvoke }
d { calling(:lambda, lambda { return "return from foo from inside proc" }) }
d { calling(:proc, proc { return "return from foo from inside proc" })}

def outofhere
  puts "\ngetting out of here"
  d { calling(:procnew, Proc.new { return "return from foo from inside proc" })}
  d { fromyield { return 'outter '} }# throws exception
end

outofhere

# Output:
#return from foo from inside proc
#
#after f.call on lambdacall
#return from lambdacall
#
#inner return from procinvoke
#
#calling: lambda
#after f.call on calling
#return from calling: lambda
#
#calling: proc
#! error: unexpected return
#
#getting out of here
#calling: procnew
