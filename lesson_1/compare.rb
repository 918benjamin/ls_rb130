def compare(str)
  puts "Before: #{str}"
  after = yield(str)
  puts "After : #{after}"
end

# method invocation
compare('hello') { |word| word.upcase }

compare('hello') { |word| word.slice(1..2) }

compare('hello') { |word| "nothing to do with anything" }

compare('hello') { |word| puts "hi" }