#!/usr/bin/env ruby
require 'pp'

class Class
  def immutable(*args)
    for name in args
      define_method("#{name}") do
        instance_variable_get("@#{name}")
      end

      define_method("set#{name}") do |val|
        ret = self.clone
        ret.instance_variable_set("@#{name}",val)
        return ret
      end

      define_method :setVars do |*args|
        dict = args[0]
        ret = self.clone
        for k, v in dict
          ret.instance_variable_set("@#{k}", v)
        end
        return ret
      end

    end
  end
end

class C
  immutable :nome, :val, :hj
end

x = C.new
a = (x.setnome('lala'))
b = x.sethj 1

c = b.setVars :nome => 'nomes', :val => 'vals', :hj => 42
pp x
pp a
pp b
pp c