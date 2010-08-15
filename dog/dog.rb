#!/usr/bin/env ruby
class Dog
  MSGS = {:dance => 'is dancing', :poo => 'is a smelly doggy!',
    :laugh => 'finds this hilarious!'}

  attr_reader :dogname, :can

  def initialize(name)
    @dogname = name
  end

  def can(*args)
    @can = args
  end

  def method_missing(name, *args, &block)
    raise "no such method #{name}" unless can.find name
    msg = MSGS[name]
    return "#{dogname} #{msg}"
  end
end