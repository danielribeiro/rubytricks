#!/usr/bin/env ruby
class A
  public_class_method :define_method
end

block = proc { puts 'hi'}

A.define_method(:hi, &block)

block = proc { puts 'overridden!'}
A.new.hi