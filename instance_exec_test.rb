#!/usr/bin/env ruby
class << Object
  def bubble(*args, &block)
    args.each do |method_name|
      define_method(method_name) do
        instance_exec(method_name, &block) if block_given?
        self
      end
    end
  end
end
class InstanceExecTest
  attr_reader :some_array

  def initialize
    @some_array = []
  end

  bubble :return_self, :return_self2 do |method_name|
    some_array << method_name.to_s
  end
#  bubble :return_self do
#    @some_array << 'from return_self'
#  end
#  bubble :return_self2 do
#    @some_array << 'from return_self2'
#  end

  def to_s
    "I am " + super
  end
end

x = InstanceExecTest.new
puts x.return_self
puts x.some_array
