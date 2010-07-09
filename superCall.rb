#!/usr/bin/env ruby
require 'pp'
class Object
  def super
    SuperCaller.new(self)
  end
end

class SuperCaller
  def initialize(caller, backsteps = 1)
    @caller = caller
    @backsteps = backsteps
    metaclass = (class << self; self; end)
    methods = caller.public_methods(true) - ['__id__', '__send__', 'super']
    methods.each do |meth|
      str = <<END
          def #{meth}(*args, &block)
            for clas in @caller.class.ancestors[#{backsteps}..-1]
              if clas.public_method_defined? :#{meth}
                return clas.instance_method(:#{meth}).bind(@caller).call(*args, &block)
              end
            end
          end
END
      metaclass.class_eval(str)
    end
  end

  def super
    SuperCaller.new(@caller, @backsteps + 1)
  end


end


class WithTwoSupers
  def to_s
    "reached"
  end

end

class A < WithTwoSupers
  def me
    'a'
  end

  def to_s
    'sou um A'
  end
end

class B < A
  def me
    'b'
  end

  def to_s
    'sou um B'
  end

end




puts B.new.super.to_s
puts B.new.super.class
puts B.new.super.super.to_s
puts B.new.super.super.super.to_s
puts B.new.super.super.super.super.to_s
puts B.new.super.super.super.super.super.to_s
puts B.new.super.super.super.super.super.super.to_s
#puts B.new.super.super.super.super.super.super.super.to_s

