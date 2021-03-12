# My implementation (Pre-walkthrough)
def each(arr)
  counter = 0

  while counter < arr.size
    yield(arr[counter]) if block_given?
    counter += 1
  end

  arr
end


# Each method invocation
test = each([1, 2, 3]) { |num| puts num }
p test