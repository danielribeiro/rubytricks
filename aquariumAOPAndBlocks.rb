#!/usr/bin/env ruby
require 'aquarium'
class A
  def hi(*args, &block)
    "hi with #{args} and block#{block}"
  end
end

include Aquarium::Aspects
Aspect.new :before, :calls_to => :hi, :in_types => A do |execution_point, obj, *args|
    puts "Entering: #{execution_point.target_type.name}
  ##{execution_point.method_name}: args = #{args.inspect}"
end

Aspect.new :before, :calls_to => :hi, :in_types => A do |execution_point, obj, *args|
    puts "Invoking : #{execution_point.target_type.name}
  ##{execution_point.method_name}: args = #{args.inspect}"
end


puts A.new.hi(5) { |x| x}
