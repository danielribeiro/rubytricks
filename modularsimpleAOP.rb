#!/usr/bin/env ruby
#with blocks!!. see aquariumaop...

class Object
  def metaclass
    class << self; self; end
  end

end

class Array
  def add(arg)
    self << arg
    arg
  end
end

class A
  def hi(*args, &block)
    puts "from A: the args are #{args} and the block is #{block}"

    'just hi'
  end
end


module ExtensionModule

  def define_inline(name, commandstr)
    evalstr =<<modeval
def #{name}(*args, &block)
  #{commandstr}
  super
end
modeval
    doeval evalstr, __method__, __LINE__
    return self
  end


  def define_inline_block(name, &blk)
    blockcallmethod = buid_blockcall(blk)
    evalstr =<<modeval
def #{name}(*args, &block)
  #{blockcallmethod} *args, &block
  super
end
modeval
    doeval evalstr, __method__, __LINE__
    return self
  end

  def define_one_block(name, &blk)
    evalstr =<<modeval
def #{name}(*args, &block)
  #{buid_blockcall blk} [args, block]
  super
end
modeval
    doeval evalstr, __method__, __LINE__
    return self
  end
  
  private
  def doeval(evalstr, metaname, line)
    module_eval evalstr, "meta_#{metaname}" + __FILE__, line
  end

  def buid_blockcall(blk)
    regex = /#<Module\:0x(\w+)/
    uniquename = regex.match(to_s)[1]
    blockcallmethod = "blockcall_#{uniquename}"
    define_method(blockcallmethod, &blk)
    blockcallmethod
  end
end




module AopSupport
  def new
    return super unless @names
    ret = super
    for m in @names
      ret.extend(m)
    end
    return ret
  end

  def pre(name, commandstr)
    getnewModule.define_inline(name, commandstr)
  end

  def pre_with_block(name, &block)
    getnewModule.define_inline_block(name, &block)
  end

  def pre_one_block(name, &block)
    getnewModule.define_one_block(name, &block)
  end

  def getnewModule
    @names ||= []
    @names.add(Module.new.extend ExtensionModule)
  end
end


class A
  extend AopSupport
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