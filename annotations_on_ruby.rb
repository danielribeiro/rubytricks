#!/usr/bin/env ruby
module AnnotationSupportAware
  def annotations
    self.class.class_annotations
  end
end

module AnnotationSupport
    def method_missing(name, *args)
    @nexannotation = [name, args]
    puts "!!! invocado #{name}"
  end

  def class_annotations
    return @annotations || {}
  end

  def method_added(name)
    puts "!!! adicionado #{name}"
    @annotations ||= {}
    unless @nexannotation == nil
      @annotations[name]  = @nexannotation
      @nexannotation = nil
    end
  end

  def self.extend_object(obj)
    puts "extend_object callbacked? #{obj}"
    super
  end

  def self.extended(clas)
    puts "extend callbacked? #{clas}"
    clas.send :include, AnnotationSupportAware
  end
end

ret = class Ex
  extend AnnotationSupport
  override
  def oi
    'oi'
  end

  override
  def sem_anota
    'não anota'
  end
end

puts Ex.class_annotations.inspect
ex = Ex.new
puts ex.oi
puts ex.annotations.inspect
