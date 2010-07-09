#!/usr/bin/env ruby
#with blocks!!. see aquariumaop...

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


# Can't be invoked twice....
def withAlias
  Class.class_eval do
    def pre(name, commandstr)
      alias_method "old_#{name}", name
      beforename =  "__before_#{name}"
      evalstr =<<classeval


def #{beforename}(*args, &block)
  #{commandstr}
end

def #{name}(*args, &block)
  __send__ :#{beforename}, *args, &block
  __send__ :old_#{name}, *args, &block
end
classeval
      class_eval evalstr, __FILE__, __LINE__

    end
  end
end

module ExtensionModule
  def self.create
    return Module.new.extend(self)
  end


  def define_inline(name, commandstr)
    evalstr =<<modeval
def #{name}(*args, &block)
  #{commandstr}
  super
end
modeval
    self.module_eval evalstr,"meta_#{__method__}" + __FILE__, __LINE__
    return self
  end

  def create_blockcall
    regex = /#<Module\:0x(\w+)/
    uniquename = regex.match(to_s)[1]
    return "blockcall_#{uniquename}"
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

  def define_one_block(name, &blk)
    blockcallmethod = create_blockcall
    define_method(blockcallmethod, &blk)
    evalstr =<<modeval
def #{name}(*args, &block)
  #{blockcallmethod} [args, block]
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

  def pre(name, commandstr)
    @names ||= []
    @names << ExtensionModule.create.define_inline(name, commandstr)
  end

  def pre_with_block(name, &block)
    @names ||= []
    @names << ExtensionModule.create.define_inline_block(name, &block)
  end
  
  def pre_one_block(name, &block)
    @names ||= []
    @names << ExtensionModule.create.define_one_block(name, &block)
  end

end



class A
  pre :hi, 'puts "the args are #{args}"
puts "the blocks is #{block}"
  '

  pre :hi, 'puts "even more before"'

  pre_with_block :hi do |*args|
    puts "invoked by a block with args = '#{args}'"
  end

  pre_one_block :hi do |argAndBlock|
    args, block = argAndBlock
    puts "!!! invoked by one a block with args = '#{args}', block = #{block}"
  end
end

x = A.new

puts x.metaclass.ancestors
puts "\n\n"
puts x.hi(5) {|x| x}