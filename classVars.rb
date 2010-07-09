#!/usr/bin/ruby
class Super
  @@my = [5, 7, 8];
  # @@my.freeze
  def yell
    cl = self.class
    puts "I am yelling #{cl}"
    puts @@my
    puts "\n"
  end

  def add(*args)
    @@my << args
  end
end 


class Down < Super
  @@my = [9, 6, 7];
end

s = Super.new
d = Down.new
s.yell
d.yell
s.add(5, 7)
s.yell
d.yell

