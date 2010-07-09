#!/usr/bin/env ruby
#safe in a file
require 'pp'

class Module
  def define(name, &block)
    if @prefix
      puts "patched with #{@prefix + '_' + name.to_s}"
      define_method(@prefix + '_' + name.to_s, &block)
    else
      define_method(name, &block)
    end

  end

  def includepatches(mod)
    extend SafePatcher
    puts "his patches are #{mod.patches.inspect}"
    prefix = SafePatcher.get_prefix_caller(caller.first)
    for clas, block in mod.patches
      dopatch(clas, prefix, &block)
    end
  end

  public :include
end

class Object
  def metaclass
    class << self; self; end
  end
  
  def meta_eval(&blk)
    metaclass.instance_eval &blk
  end

  # Adds methods to a metaclass
  def meta_def(name, &blk)
    metaclass.class_def name, &blk
  end

  # Defines an instance method within a class
  def class_def(name, &blk)
    send :define_method, name, &blk
  end
end

module ObjectMissing
  def method_missing(name, *args, &block)
    otherName = SafePatcher.get_prefix()  + '_' + name.to_s
    puts "--> the other name is #{otherName}"
    return super unless respond_to? otherName
    return send otherName, *args, &block
  end
end


module Extended
  def extended(mod)
    puts "I -- #{self}--was extended by #{mod}"
    mod.metaclass.include Extended
    super
  end
end

module SafePatcher
  def self.get_prefix
    get_prefix_caller(caller(2).first)
  end

  def self.get_prefix_caller(cal)
    prefix = cal.first.split(':')[0]
    prefix.gsub(/[\/:.]/, '_')
  end

  def patch(clas, &block)
    prefix = SafePatcher.get_prefix
    dopatch(clas, prefix, &block)
  end

  def dopatch(clas, prefix, &block)
    @patches ||= {}
    @patches[clas] = block
    clas.instance_variable_set(:@prefix, prefix)
    clas.class_eval &block
    clas.include ObjectMissing
  end


  def patches
    @patches
  end
  
  metaclass.include Extended
end

module Work

  def self.invoke_hi(arg)
    puts arg.hi
  end
  extend SafePatcher
  patch Array do
    define :hi do
      'mwhahahahhah'
    end
  end
  puts [].hi

end

