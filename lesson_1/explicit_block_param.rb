# def test(&block)
#   puts "What's &block? #{block}"
# end

# test { "stringy" }

def test2(block)
  puts "hello"
  block.call
  puts "good-bye"
end


def test(&block)
  puts "1"
  test2(block)
  puts "2"
end

test { puts "xyz" }
# 1
# hello
# xyz
# good-bye
# 2