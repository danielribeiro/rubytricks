class A
  attr_accessor :l
  def logged_in?
    l
  end
  
  def doit(val)
    block = lambda do
      query = val.strip
      return [] if query.empty?
      'yes'
    end
    begin
      block.call if logged_in?
    rescue Exception => ex
      puts ex.message + "\n      " +
        ex.backtrace.join("\n      ")
      return { :error => ex.message }
    end
    return { :error => 'authentication required'}
  end
end

a = A.new
a.doit("  ")

