#!/usr/bin/ruby
class Me
  @var = 'hi'

  def self.sayvar
    return @var
  end

  def self.classvar(name)
    self.instance_variable_get(name)
  end

  def instance_sayvar
    return self.class.classvar(:@var)
  end

end

puts Me.sayvar

puts Me.new.instance_sayvar
