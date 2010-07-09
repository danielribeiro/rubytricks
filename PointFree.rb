#!/usr/bin/env ruby


class ProcWithBlock < Proc
  def self.new(*args, &block)
    return super {}
  end

  def call(*args, &block)
    raise "subclass responsability"
  end

end

class SendingProc < ProcWithBlock
  def initialize(target, method)
    @target, @method = target, method
  end

  def call(*args, &block)
    @target.__send__ @method, *args, &block
  end
end

class UnboundSendingProc < ProcWithBlock
  def initialize(method)
    @method = method
  end

  def call(*args, &block)
    rest = args[1..-1]
    args.first.__send__ @method, *rest, &block
  end
end

class CurriedProc < ProcWithBlock
  def initialize(args, delegate)
    @args, @delegate = args, delegate
  end

  def call(*args, &block)
    realArgs = [].push(*@args).push(*args)
    @delegate.call *realArgs, &block
  end
end


class Proc
  def o(aproc = nil, &block)
    return composewithproc(block) if block_given?
    return composewithproc(aproc) if aproc.kind_of?(Proc)
    o(&aproc)
  end

  def composewithproc(other)
    proc { |*args| call(other.call *args)}
  end


  def with(*args)
    raise ArgumentError.new("Bad numer of arguments: #{args.length}") if args.empty?
    return CurriedProc.new(args, self)
  end
end



class A
  def metodo
    return proc do |x|
      puts x
    end
  end
end
module Lazy
	module ClassMethods
    def method_added(id)
      puts "added #{id} to #{self}"
      return if @lock
      @lock = true
      puts "lock is #{@lock}"
      alias_method("#{id}_old", id)
      ret= <<-EOF
              def #{id}
                SendingProc.new(self, :#{id}_old)
              end
      EOF
      class_eval ret
      @lock = false
    end


  end
  module InstanceMethods

  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end


class LazyA
  include Lazy
  def metodo(*args, &block)
    puts "meus args foram #{args}"
    puts "block invocom com os args é"
    puts block.call(*args)
  end
end


x = A.new
#x.metodo.o do |y| y * 2 end.call 6
x.metodo.o(:even?).call 6
puts '----'
l = LazyA.new
puts LazyA.ancestors
l.metodo.call(5) { |y| y * 2 }

puts '----'

class UnboundMethod
  def to_proc
    proc { |*args|
      rest = args[1..-1]
      bind(args[0]).call(*rest)
    }
  end
end

module Kernel
  def funcof clas, name
    proc &(clas.instance_method name)
  end

  def func name
    UnboundSendingProc.new(name)
  end
end

module LazyModule
  include Lazy
  def words(str)
    str.split(" ")
  end

  def filter(w, str)
    str.select {|x| x == w}
  end

end

module StrictModule
  def self.fun(*args)
    for name in args
      define_method(name) do
        func name
      end
    end
  end
  fun :length
end



include LazyModule
include StrictModule
p = length.o filter.with('is').o words
puts p.call 'this is very good or is it bad. is ?'
#compare with:
puts 'this is very good or is it bad. is ?'.split(" ").select { |a| a == 'is'}.length

puts '----'
class Array
  def call *args, &block
    func = inject{ |memo, arg| memo.o arg }
    func.call *args, &block
  end
end


module App
  extend LazyModule
  extend StrictModule
  puts [length, 
    filter.with('is'),
    words].call 'this is very good or is it bad. is ?'
end