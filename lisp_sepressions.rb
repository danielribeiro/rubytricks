#!/usr/bin/env ruby
require 'pp'


class SexpressionSupport
  (public_instance_methods(true) - ['__id__', '__send__', 'instance_eval']).each do |meth|
    str = <<END
          def #{meth}(*args, &block)
            method_missing(:#{meth}, *args, &block)
          end
END
    class_eval(str)
  end

  def method_missing(name, *args)
    return name
  end

  def __call__(blk)
    instance_eval &blk
  end
end

def sexpr(&blk)
  SexpressionSupport.new.__call__ blk
end


pp sexpr {
  [computer,
    [processor,
      [cores, 2],
      [type, 386]],
    [disk,
      [size, 150]],
    [disk,
      [size, 75],
      [speed, 7200, max],
      [interface, sata]]]
}

