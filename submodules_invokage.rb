#!/usr/bin/env ruby
class A
  def self.go
    puts 'go'
  end

  class B
    def call
      A.go
    end
  end
end

A::B.new.call