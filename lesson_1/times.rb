def times(int)
  arr = (0...int).to_a
  arr.each do |num|
    yield(num) if block_given?
  end
  int
end

times(5) do |num|
  puts num
end