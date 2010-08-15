class A
  def getFirst(&bl)
    ar = (1..9).to_a
    ar.each &bl
    return 'died on you'
  end

  def getb
    arg = 5
    proc do |i|
      if i > arg
        return i
      end
    end
  end

  def all2
    arg = 5
    bl = proc do |i|
      if i > arg
        return i
      end
    end
    ar = (1..9).to_a
    ar.each &bl
    return 'died on you'
  end
end



a = A.new
puts a.all2 # returns 6
puts a.getFirst(&a.getb)