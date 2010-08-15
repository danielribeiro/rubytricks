foo = lambda do
  (1..2).each do |j|
    return
  end
end
foo.call