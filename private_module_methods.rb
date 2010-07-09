#!/usr/bin/env ruby
module X
  def call
    puts 'calling on x'
    blockcall
  end

  private
  def blockcall
    puts 'on x'
  end
end

module Y
  def call
    puts 'calling on Y'
    blockcall
    super
  end

  private
  def blockcall
    puts 'on Y'
  end
end

class A
  include X
  include Y
end

A.new.call