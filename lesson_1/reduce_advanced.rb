# My solution
def reduce(array)
  counter = 1
  result = array[0]

  while counter < array.size
    result = yield(result, array[counter])
    counter += 1
  end

  result
end


# Method invocation
abc = reduce(['a', 'b', 'c']) { |acc, value| acc += value }
p abc # "abc"

puts ""

arr = reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value }
p arr # [1, 2, 'a', 'b']