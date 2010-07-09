#!/usr/bin/env ruby
class Object
  def sendcc(symbol, *args)
    mycc = nil
    callcc {|cc|
        mycc = cc
    }
    begin
      send(symbol, *args)
    rescue NoMethodError => ex
      puts "error while sending #{symbol} to #{self}"
      puts ex
      puts ex.backtrace.join("\n")
      if mycc.nil?
        puts "it is over boy"
      else
        puts "redoing with method appended with +h. One try only"
        symbol = (symbol.to_s + "h").to_sym
        oldcc = mycc
        mycc = nil
        oldcc.call
      end
      

    end

    
  end
end

puts "123".sendcc :lengt
