require 'minitest/autorun'
# require 'minitest/reporters'
# MiniTest::Reporters.use!

def square_root(value)
  Math.sqrt(value).to_i
end

class SquareRootTest < MiniTest::Test
  def test_that_square_root_of_9_is_3
    result = square_root(9)
    assert_equal 3, result
  end

  def test_that_square_root_of_17_is_4
    result = square_root(17)
    assert_equal 4, result
  end
end