#!/usr/bin/env ruby
require 'forwardable'
require 'pp'
#module Kernel
#  alias require_old require
#  def require(str)
#    puts "requiring: #{str}"
#    if str == 'rubygems'
#      puts "!DEVIL"
#      pp caller
#    end
#    require_old(str)
#  end
#end


require 'ruby2ruby'
require 'sexp_processor'
require 'unified_ruby'
require 'parse_tree'


# Inpsired on Monkey-patch to have Ruby2Ruby#translate with r2r >= 1.2.3, from
# http://seattlerb.rubyforge.org/svn/ruby2ruby/1.2.2/lib/ruby2ruby.rb

class SelfAnalizable
  define_method(:lala) {
#    x = 6
#    a, b = 1, 6
#    ar.map _.and(5).meat
#    ar.map { |x| x.and(5).meat}
    i = create
    map(i.go(compute(_)))
    map(i.go(compute(_ + 5)))
    map(:lala) { i.go(compute(_)) }
    map(:lala) { |x| i.go(compute(x))}
#    map compute(_)
#    if arg1 == 0 then
#      return 1
#    end
#    for i in 1..5
#      puts i
#    end
#    y = x + a + double!("string literal")
#    y += 1 if y > 10
#    if y > 10
#      x += 1
#    end
#    z = y +x + 5 + 6
#    return y
  }

  def analize(target = self.class, method = :lala)
    ret = ParseTree.translate(target, method)
    pp ret
    ret
  end
end



sexp = SelfAnalizable.new.analize
unifier = Unifier.new
unifier.processors.each do |p|
  p.unsupported.delete :cfunc
end
sexp = unifier.process(sexp)
puts Ruby2Ruby.new.process(sexp)