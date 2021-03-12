# My solution
def select(array)
  new_array = []
  counter = 0

  while counter < array.size
    block_return = yield(array[counter])
    new_array << array[counter] if block_return
    counter += 1
  end

  new_array
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