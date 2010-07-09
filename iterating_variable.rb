#!/usr/bin/env ruby
#from http://dogbiscuit.org/mdub/weblog/Tech/Programming/Ruby/MethodMissingMagic
def double(x)
   x * 2
end

class Object
  def dobra
    return self * 2
  end
end

class MessageBuffer
  instance_methods.each do |m|
    undef_method m unless m =~ /^(__|respond_to|inspect)/
  end

  def initialize
    @messages = []
  end

  def method_missing(*args, &block)
    @messages << [args, block]
    self
  end

  def __replay_all_messages__(obj)
    lastarg = nil
    @messages.inject(obj) do |obj, message|
      args, block = message
      lastarg = obj.__send__(*args, &block)
      lastarg
    end
    puts "lastarg = #{lastarg}"
    return lastarg
  end

  def to_proc
    proc { |x|
      ret = __replay_all_messages__(x)
      puts "returning #{ret}"
      ret
      }
  end

end

def it
  MessageBuffer.new
end

def prime(arg)
  puts arg
  return nil
end

p 'real case'
puts [1, 2, 3].map(&double(it))
#failed case:
p 'failed case'
puts [1, 2, 3].map(&prime(it))

p 'regular case'
puts [1, 2, 3].map {|it| puts(it)}

p 'hands on case'
p = it.split(" ").select { |a| a == 'is'}.length
p.__replay_all_messages__('this is very good or is it bad. is ?')