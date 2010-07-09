#!/usr/bin/ruby
require 'set'

class Class
  def java_attr_accessor(*accessors)
    accessors.each do |m|
      beanName = m.to_s.capitalize
#     v1:
      define_method("get#{beanName}") do
        eval("return @#{m}")
      end
#      v2
      define_method("get#{beanName}") do  
        instance_variable_get("@#{m}")
      end
      #v3
      eval "define_method(\"get#{beanName}\") do
        return @#{m}
      end"
      # v4
      str = "def get#{beanName}
  return @#{m}
end"
      eval str

      define_method("set#{beanName}") do |val|
        instance_variable_set("@#{m}",val)
      end
    end
  end
end


class Base
  java_attr_accessor :name
end

b = Base.new
b.setName("fnord")
puts b.getName
