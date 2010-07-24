#!/usr/bin/env ruby
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

class Symb < Symbol
  public_instance_methods(true).each do |m|
    undef_method m unless m =~ /^__/
  end

  def self.new(*args)
    self.super.new *args
  end

  def initialize(s)
    @s = s
  end

  def method_missing(name, *args, &block)
    @s.__send__ name, *args, &block
  end

end
l = [1, 2, 3]
p l.inject Symb.new(:+)