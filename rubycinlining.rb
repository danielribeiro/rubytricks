#!/usr/bin/env ruby
require "inline"


class MyTest
  inline do |builder|
    builder.c "
      struct Point {
        int x;
        int y;
      };

      stuct Point fat(int max) {
        struct Point p;
        p.x = 5;
        p.y = 10;
        return p;
      }"
  end
end
t = MyTest.new()
puts t.fat(5)

