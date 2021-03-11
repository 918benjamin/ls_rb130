# method definition
def test
  yield(1)
end

# method invocation
test { |num1, num2| p "#{num1} #{num2}" }
