#!/usr/bin/env ruby
require 'pp'

require 'ruby2ruby'
require 'sexp_processor'
require 'unified_ruby'
require 'parse_tree'

class JustAClass
  def anarray
    return [1, 2, 3]
  end

  def anarrayWithPuts
    puts "in here"
    return [1, 2, 3]
  end

end

#def analizeAll()

class Methodanalyzer
  attr_reader :unifier
  def initialize
    @unifier = Unifier.new
  end

  def analize(targetClass, method)
    ret = ParseTree.translate(targetClass, method)
    puts '### Translation: '
    pp ret
    ret
  end

  def get(clas, *args)
    for method in args
      doGet(clas, method)
    end
    
  end

  def doGet(clas, method)
    sexp = analize(clas, method)
    unifier.processors.each do |p|
      p.unsupported.delete :cfunc
    end
    sexp = unifier.process(sexp)
    puts '### In ruby str:'
    puts Ruby2Ruby.new.process(sexp)
  end

  def enhance(clas, method)
    sexp = ParseTree.translate(clas, method)
    r = PutsEnhancer.new.process(sexp)
    strToEval = Ruby2Ruby.new.process(unifier.process(r))
    clas.class_eval strToEval
  end
end


# Inspired on http://www.zenspider.com/ZSS/Products/ParseTree/Examples/Dependencies.html
class PutsEnhancer < SexpProcessor

  def initialize
    super
    @alternate = SexpProcessor.new
  end

  def proceed(exp)
    @alternate.process exp
  end

  def process_block(exp)
    #    proceed exp
    internal = s(:fcall, :puts, s(:array, s(:str, "in here")))
    return s(exp.shift, process(exp.shift), internal, process(exp.shift))
  end

end

inst = JustAClass.new
m = Methodanalyzer.new
#m.get JustAClass, :anarray, :anarrayWithPuts Dev mode
out = inst.anarray
p out
m.enhance JustAClass, :anarray
out = inst.anarray # try and debug this! oh the horror!
p out