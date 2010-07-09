#!/usr/bin/ruby
require 'set'

class Class
  def attr_default(*accessors)
    partitioned = [accessors[0]]
    for method in accessors
      puts "method = #{method}"
    end
    # accessors.each do |m|
    #   beanName = m.to_s.capitalize
    #   define_method("get#{beanName}") do  
    #     instance_variable_get("@#{m}")
    #   end        

    #   define_method("set#{beanName}") do |val| 
    #     instance_variable_set("@#{m}",val)
    #   end
    # end
  end
end


class Base
  attr_default :name, 9
  # attr_accessor :name
  
  def to_hash
    h = {}
    instance_variables.each { |v| h[v] = instance_variable_get(v)}
    return h
  end

  def inspect
    to_hash.inspect
  end


end


x = Base.new
x.dois = 'oi'
puts x.inspect
