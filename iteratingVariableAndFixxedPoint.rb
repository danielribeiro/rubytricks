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

module LazyModule
  include Lazy
  def words(str)
    str.split(" ")
  end

  def filter(w, str)
    str.select {|x| x == w}
  end

end

class MessageBuffer < ProcWithBlock
  def initialize
    @messages = []
  end

  def method_missing(*args, &block)
    @messages << [args, block]
    self
  end

  def call(obj)
    lastarg = nil
    @messages.inject(obj) do |obj, message|
      args, block = message
      lastarg = obj.__send__(*args, &block)
      lastarg
    end
    puts "lastarg = #{lastarg}"
    return lastarg
  end

end

def it
  MessageBuffer.new
end


include LazyModule
p = it.length.o filter.with('is').o words
puts p.call 'this is very good or is it bad. is ?'
#compare with:
puts 'this is very good or is it bad. is ?'.split(" ").select { |a| a == 'is'}.length

puts
r = it.split(" ").select { |a| a == 'is'}.length
puts "output"
puts  r.call 'this is very good or is it bad. is ?'