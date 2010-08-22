#!/usr/bin/env ruby
def myfind(ar)
  ar.each do |i|
    if i > 4
      return i
    end
  end
end

def myfind_bl(ar, &block)
  ar.each &block
end

def myfind_with_for(ar)
  for i in ar
    if i > 4
      return i
    end
  end
end

p myfind [1, 3, 9, 12]
p myfind_with_for([1, 3, 9, 12])
p myfind_bl([1, 3, 9, 12]) { |i| return i if i > 40}
p myfind_bl([1, 3, 9, 12]) { |i| puts self}
p myfind_bl([1, 3, 9, 12]) { |i| i if i > 4}
x = myfind_bl [1, 3, 9, 12] do |i|
  if i > 4
    return i
  end
end
p "x is #{x}" # never gets here
puts 'never got here'