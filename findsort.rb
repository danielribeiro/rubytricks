#!/usr/bin/env ruby
#finds a dir and sort it
require 'find'

class FileObject
  include Comparable
  attr_reader :stat, :path

  def <=>(o)
    stat <=> o.stat
  end

  def initialize(path)
    @path = path
    @stat = File.stat(path)
  end
end

class Printer

  def initialize
  end

  def printsorted(dir)
    list = []
    Find.find(dir) do |path|
      list << FileObject.new(path) if File.file? path
    end
    for f in list.sort
      time = f.stat.mtime.strftime "%d-%m-%Y %H:%M"
      puts "#{time} #{f.path}"
#      puts Iconv.iconv 'latin1', 'utf8', "#{time} #{f.path}"
    end
  end

  def doit(args)
    return puts "Use: %s dirname" % __FILE__ if args.length != 1
    printsorted args.first
  end
end




if $PROGRAM_NAME == __FILE__
  Printer.new.doit ARGV
end