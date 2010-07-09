#!/usr/bin/env ruby
module Global
    def method_missing(name, *args, &block)
      if args.length < 1
        return super
      end
      target = args.first
      tail = args[1..-1]
      if not target.respond_to?(name, true)
        return super
      end
      target.send(name, *tail, &block)
    end
end

module Enumerable
  def sum
    inject(0) { |sum, n| sum + n }
  end
end


puts [1, 2, 3].sum

include Global
puts sum [1, 2, 3]
puts inject([1, 2, 3], 0) {|sum, n| sum + n}
puts length [1, 2, 3]

def length(arg)
  return "custom invoked length #{arg.length}"
end


puts length [1, 2, 3]
