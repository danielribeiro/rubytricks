#!/usr/bin/env ruby

#from http://ruby.tie-rack.org/6/safely-overriding-method_missing-in-a-class-that-already-has-it/
class A
  def foo
    p "A.foo"
  end
end
class B
end

module M
  NoGC = []

  def self.included other
    other.module_eval do
      if((foo = instance_method 'foo' rescue false))
        NoGC.push foo
        supra = "ObjectSpace._id2ref(#{ foo.object_id }).bind(self).call(*a, &b)"
      end
      eval <<-code
         def foo *a, &b
           #{ supra }
           p "M.foo"
         end
      code
    end
  end
end

A.send :include, M
B.send :include, M

A.new.foo
B.new.foo
