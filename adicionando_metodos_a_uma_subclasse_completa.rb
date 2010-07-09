  #!/usr/bin/env ruby

class Pai
  def self.inherited(subclass)
    met = subclass.public_instance_methods.sort.join("\n")
    puts "I was inherited by: #{subclass.name}. Its methods are #{met}"
  end

  def self.method_added(id)
    puts "!! added the mothod of name #{id}"
  end
end

class Filho < Pai
  def amethod
    puts 'amethod'
  end
end

met = Filho.public_instance_methods.sort.join("\n")
puts "Filho methods are: #{met}"