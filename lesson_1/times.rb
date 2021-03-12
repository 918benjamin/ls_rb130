# LS Walkthrough
def times(number)
  counter = 0
  while counter < number do
    yield(counter)
    counter += 1
  end

  number
end


# My implementation (first shot, pre-walkthrough)
# def times(int)
#   arr = (0...int).to_a
#   arr.each do |num|
#     yield(num) if block_given?
#   end
#   int
# end

# Method invocation
times(5) do |num|
  puts num
end