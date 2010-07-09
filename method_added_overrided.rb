#!/usr/bin/env ruby
require 'pp'

puts 'begin'
class Class
  def metaclass
    class << self; self; end
  end
end

class Module
  @redefiningMethodAdded = false

  

  def method_added_callback(id)
    puts "---> Class #{__method__}: Adding method of name :#{id} added to #{self}. "
    pp caller
  end


  def singleton_method_added(id)
    if @redefiningMethodAdded
      puts "it is all right, you can add #{id} to #{self}"
      return
    end
    if id == :method_added
      puts "dam you #{self}. i'll not let you do that add method added."
      @redefiningMethodAdded = true
      oldMAdded = self.method(:method_added)
      metaclass.__send__(:define_method, :method_added) { |idb|
        oldMAdded.call(idb)
        method_added_callback(idb)
      }
      @redefiningMethodAdded = false
    else
      puts "---> #{__method__}:  Class method of name :#{id} added to #{self}"
    end
    
  end

  def method_added id
    method_added_callback(id)
  end
end

class Screamer
  def self.method_added(id)
    puts "screamer says: Adding #{id}"
  end
end



class A < Screamer

  def oii
    'oi'
  end
end
