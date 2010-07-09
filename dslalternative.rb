#!/usr/bin/env ruby
require 'pp'

class GenericDslSupport
  (public_instance_methods(true) - ['__id__', '__send__', 'instance_eval']).each do |meth|
    str = <<END
          def #{meth}(*args, &block)
            method_missing(:#{meth}, *args, &block)
          end
END
    class_eval(str)
  end

  def self.dsl(&block)
    GenericDslSupport.new.instance_eval(&block)
  end

  
  def initialize
    @ret = []
  end

  def method_missing(name, *args, &block)
    raise "cannot have block and arguments" unless args.empty? or block == nil
    return name if args.empty? and block == nil
    return _head_with_block(name, block) if block
    _list_with_args(name, args)
  end

  def _head_with_block(name, block)
    _tail_content name, GenericDslSupport.dsl(&block)
  end

  def _list_with_args(name, args)
    _tail_content name, args
  end

  def _tail_content(name, content)
    @ret << [name].push(*content)
  end


end

def dsl(&blk)
  GenericDslSupport.dsl &blk
end

def fat n
  return n if n <= 1
  return n * fat(n - 1)
end

x = dsl {
  computer do
    processor {
      cores 2
      type 386
    }
    disk {
      size fat(50)
    }
    disk {
      size 75
      speed 7200, max
      interface sata
    }
  end
}

pp x[0]
