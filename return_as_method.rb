#!/usr/bin/env ruby
def invoca
  ret { 6 }
  return "never returned"
end

#graças ao facets
def ret(&block)
  rval = block.call
  eval("return #{rval}", block)
end

puts invoca

class A
  def return(&block)
    rval = block.call
    Kernel.eval("return #{rval}", block)
  end

  def invoca
    self.return {6}
    return "never returned"
  end

  def do
      return "do invoked"
  end

end


puts A.new.invoca
puts A.new.do