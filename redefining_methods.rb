#!/usr/bin/env ruby
#inspired on http://blog.jayfields.com/2008/04/alternatives-for-redefining-methods.html
def enhance(clas, name)
  id = ":#{name}"
  str = <<EOF
class #{clas}
  @@methods ||= {}
  @@methods[#{id}] = instance_method(#{id})
  class_eval do
    def process(*args, &block)
      puts "do something else"
      @@methods[#{id}].bind(self).call(*args, &block)
    end
  end
end
EOF
  Kernel.eval str
end

class A
  @lock = false
  def self.method_added(id)
    puts "added #{id} to #{self}"
    return if @lock
    @lock = true
    enhance self, id
    @lock = false
  end
end

class A
  def process(*args, &block)
    puts "meus args foram #{args}"
    if block.nil?
      puts "no block"
    else
      puts "block invocom com os args é"
      puts block.call(*args)
    end
  end
end




A.new.process(1, 2) { |x, y|  x + y}