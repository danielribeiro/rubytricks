#!/usr/bin/env ruby
x = proc do |*args|
  puts local_variables
end

x.call(1, 2)

def hm
  "printthem(binding, local_variables)"
end

def printthem(bind, lvariables)
  ret = {}
  for i in lvariables
    ret[i] = eval("#{i}", bind)
  end
  return ret
end

def alfa(one, two)
  eval hm
end
p alfa(2, 3)