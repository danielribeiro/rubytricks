#!/usr/bin/env ruby
#DOES NOT WORK
#
#
#BAzooka: maybe with annotations
#ObjectSpace.each_object(Class) do |i|
#  Kernel.send :define_method, i.name.to_sym do |*args|
#       i.new *args
#  end
#end



module Newless
  def method_missing(name, *args, &block)
    clas = Kernel.const_get(name)
    clas.new *args, &block
  end
end
#def Struct(*args)
#  return Struct.new(*args)
#end

include Newless
A = Struct :name, :surname

pg =  A 'Paul', 'Graham'
puts pg
name, sur = pg
puts "names is #{name}, sur is #{sur}"