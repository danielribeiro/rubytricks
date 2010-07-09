#!/usr/bin/env ruby
class Module
  public :include
end

class Object
  def metaclass
    class << self; self; end
  end
end

class A
  def hi(*args, &block)
    puts "from A: the args are #{args} and the block is #{block}"

    'just hi'
  end
end


module ExtensionModule
  def self.create
    return Module.new.extend(self)
  end


  def create_blockcall
    ## Commenting the following two lines the seg fault turn into  `new': stack level too deep
    # regex = /#<Module\:0x(\w+)/
    # uniquename = regex.match(to_s)[1]
    ##

    return "blockcall_#{object_id}"
  end

  def define_inline_block(name, &blk)
    blockcallmethod = create_blockcall
    define_method(blockcallmethod, &blk)
    evalstr =<<modeval
def #{name}(*args, &block)
  #{blockcallmethod} *args, &block
  super
end
modeval
    self.module_eval evalstr, "meta_#{__method__}" + __FILE__, __LINE__
    return self
  end
end

class Class
  alias oldnew new

  def new
    return oldnew unless @names
    ret = oldnew
    for m in @names
      ret.extend(m)
    end
    return ret
  end

  def pre_with_block(name, &block)
    @names ||= []
    @names << ExtensionModule.create.define_inline_block(name, &block)
  end

end



class A

  pre_with_block :hi do |*args|
    puts "invoked by a block with args = '#{args}'"
  end
end


puts 'ok'
