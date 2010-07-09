# To change this template, choose Tools | Templates
# and open the template in the editor.

class Scala
  def initialize(argImplicito, target, &block)
    @argImplicito = argImplicito
    @target = target
    self.instance_eval(&block)
  end

  def method_missing(symbol, *args)
    begin
      @target.send(symbol, *args)
    rescue ArgumentError => ex
      newArgs = args << @argImplicito
      @target.send(symbol, *newArgs)
    end
  end

end

class Target
  def saida(arg)
    puts arg
  end
end

x = Target.new
Scala.new("implicito", x) do
  saida
end
