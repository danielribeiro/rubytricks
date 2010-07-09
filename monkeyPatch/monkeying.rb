#!/usr/bin/ruby
class Monkey

end

Monkey.send(:define_method, :div) do |n|
  return 5 / n
end

puts Monkey.new.div(0)