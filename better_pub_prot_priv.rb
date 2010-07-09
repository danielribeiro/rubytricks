#!/usr/bin/env ruby
class A
  @added = nil

  def self.method_added(name)
    @added = name
  end

  def self.priv(onearg)
    if not @added.nil?:
        private @added
        @added = nil
    end
  end


  priv def oi
    'oi'
  end
end

puts A.new.oi