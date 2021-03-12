# My solution
# def select(array)
#   new_array = []
#   counter = 0

#   while counter < array.size
#     block_return = yield(array[counter])
#     new_array << array[counter] if block_return
#     counter += 1
#   end

#   new_array
# end

# LS Solution
def select(array)
  counter = 0
  result = []

  while counter < array.size
    current_element = array[counter]
    result << current_element if yield(current_element) # we don't need to assign
    # the block return value to anything because we can simply reference it directly
    # but this won't work for a Array#map clone
    counter += 1
  end

  result
end

# Method invocation
array = [1, 2, 3, 4, 5]

odds = select(array) { |num| num.odd? }
p odds # [1, 3, 5]

puts ""

puts_num = select(array) { |num| puts num }
p puts_num # []

puts ""

increment = select(array) { |num| num + 1 }
p increment # [1, 2, 3, 4, 5]