#!/usr/bin/ruby
require 'set'

$filename =
  '/home/daniel/workspace/ExamplesFluentJava/src/main/java/org/examplesFluentjava/Examples.java'

class JavaMethod
  attr_accessor :name
  def initialize
    @body = ''
  end

  def addText(text)
    @body += text
  end

  def to_s
    return "METHOD = #{@name}=\n#{@body}"
  end

  def titleMethod
    ret = ''
    @name.each_char do |c|
      if c =~ /[A-Z]/
        if !ret.empty?
          ret += ' ' 
        end
      end
      ret += c
    end
    return ret
  end

  def typeAndName
    titleMethod =~/(\S+)\s(.*)/
    return [$1.capitalize, $2]
  end

  def asCode
    puts "{{{\n"
    puts @body
    puts "}}}\n"
  end

  def asCodeWithHeading
    puts "=== #{typeAndName[0]} ==="
    asCode
  end
end


def extractMethodName(line)
  if line =~ /public void (\w+)\(\).*/
    return $1
  end
end

def evaluate
  onMethod = false
  started = false
  metodos = []
  File.open($filename, "r") do |file|
    file.each do |line|
      started = line.include?('public void fluentCast()') unless started
      if started
        stripedLine = line[1..-1]
        methodName = extractMethodName(stripedLine)
        if methodName
          onMethod = true
          m = JavaMethod.new
          m.name = methodName
          metodos << m
        elsif onMethod and !stripedLine.strip().empty?
          metodos[-1].addText(stripedLine[1..-1])
        elsif onMethod and stripedLine.strip() == '}'
          onMethod = false
        end
      end
    end
  end
  
  h = Hash.new { |hash, key| hash[key] = [] }
  metodos.map do |m|
    h[m.typeAndName[1]] << m
  end
  
  seen = Set.new
  metodos.each do |m|
    realTitle = m.typeAndName[1]
    if !seen.include? realTitle
      seen << realTitle    
      puts "== #{realTitle} =="
      examples = h[realTitle]
      if examples.size == 1
        examples[0].asCode
      else
        examples.each {|e| e.asCodeWithHeading}
      end
    end
  end

end

evaluate()
