#!/usr/bin/ruby
set_trace_func proc { 
  |event, file, line, id, binding, classname| 
  printf "!!! event = %8s, file/line = %s:%-2d, id=%10s classname=%8s\n", event, file, line, id, classname 
} 

class Test
  def sumall(list)
    len = list.size
    puts "list with = #{len} elements"
    sum = 0
    for clo in list do
      sum += clo.call
    end
    puts "sum = #{sum}"
  end

  def test()
    x = []
    i = 0
    while i < 10 do
      x << lambda { return i }
      i += 1
      sumall(x) if i == 5
    end

    sumall(x)
  end

end

Test.new.test
