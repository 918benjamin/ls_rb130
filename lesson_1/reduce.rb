# My initial solution
def reduce(array, default_acc=0)
  counter = 0
  result = default_acc

  while counter < array.size
    result = yield(result, array[counter])
    counter += 1
  end

  result
end

# Method invocation examples
array = [1, 2, 3, 4, 5]

added = reduce(array) { |acc, num| acc + num }
p added # 15

puts ""

ten_added = reduce(array, 10) { |acc, num| acc + num }
p ten_added # 25

reduce(array) { |acc, num| acc + num if num.odd? } # NoMethodError exception raised