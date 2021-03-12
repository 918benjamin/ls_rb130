# My implementation (Pre-walkthrough)
# def each(arr)
#   counter = 0

#   while counter < arr.size
#     yield(arr[counter]) if block_given?
#     counter += 1
#   end

#   arr
# end

# LS Implementation (walkthrough)
def each(array)
  counter = 0

  while counter < array.size
    yield(array[counter])
    counter += 1
  end

  array
end


# Each method invocation
# test = each([1, 2, 3]) { |num| puts num }
# p test

# puts ""

# each([1, 2, 3, 4, 5]) do |num|
#   puts num
# end

odds = each([1, 2, 3, 4, 5]) { |num| "do nothing" }.select { |num| num.odd? }
puts odds