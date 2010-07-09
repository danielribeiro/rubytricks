#!/usr/bin/env ruby
class Super
  def self.attr_writer *args
    super *args
    puts "invoked with #{args}"
  end
end

class Client < Super
  attr_writer  :name, :age
end

c = Client.new
c.age = 50
c.name = 'mf'
puts c