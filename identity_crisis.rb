#!/usr/bin/env ruby
class B
  @@x = lambda { puts self}

  def self.x
    @@x
  end
end

class A
  x = lambda { puts self}
  x.call
  B.x.call

end