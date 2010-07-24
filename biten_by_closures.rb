#!/usr/bin/env ruby
# Joshua and Neal Gafter block told us about it

class A
  
end

ar = ['a', 'div', 'lu']
#for name in ar
#  A.send(:define_method, name) { name }
#end

#p A.new.a # yes, it is lu

# but
ar.each do |name|
  A.send(:define_method, name) { name }
end

p A.new.a # yes, it is a!
p A.new.div # yes, it is div!