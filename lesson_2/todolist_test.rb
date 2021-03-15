require 'minitest/autorun'
require 'minitest/reporters'
MiniTest::Reporters.use!

require_relative 'todolist'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first) # LS uses assert_equal but I'm getting an error
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    assert_equal(@todo1, @list.shift)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    assert_equal(@todo3, @list.pop)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done
    assert_equal(false, @list.done?)
    @list.done!
    assert_equal(true, @list.done?)
  end

  def test_type_error
    assert_raises(TypeError) { @list << 1 }
    assert_raises(TypeError) { @list << 'hi' }
  end

  def test_append
    new_todo = Todo.new("New todo")
    @list << new_todo
    @todos << new_todo
    assert_equal(@todos, @list.to_a)
  end

  def test_add
    new_todo = Todo.new("New todo")
    @list.add(new_todo)
    @todos << new_todo
    assert_equal(@todos, @list.to_a)
  end

  def test_item_at
    assert_equal(@todo2, @list.item_at(1))
    assert_raises(IndexError) { @list.item_at(4) }
  end

  def test_mark_done_at
    assert_raises(IndexError) { @list.mark_done_at(100) }
    assert_equal(false, @list.item_at(1).done?)
    @list.mark_done_at(1)
    assert_equal(true, @list.item_at(1).done?)
    assert_equal(false, @list.item_at(2).done?)
    assert_equal(false, @list.item_at(0).done?)
  end

  def test_mark_undone_at
    assert_raises(IndexError) { @list.mark_undone_at(100) }
    assert_equal(false, @list.item_at(1).done?)
    @list.mark_done_at(1)
    assert_equal(true, @list.item_at(1).done?)
    assert_equal(false, @list.item_at(0).done?)
    assert_equal(false, @list.item_at(2).done?)
    @list.mark_undone_at(1)
    assert_equal(false, @list.item_at(1).done?)
    assert_equal(false, @list.item_at(0).done?)
    assert_equal(false, @list.item_at(2).done?)
  end

  def test_done!
    assert_equal(false, @list.done?)
    @list.done!
    assert_equal(true, @list.done?)
    assert_equal(true, @list.item_at(0).done?)
    assert_equal(true, @list.item_at(1).done?)
    assert_equal(true, @list.item_at(2).done?)
  end

  def test_remove_at
    assert_raises(IndexError) { @list.remove_at(100) }
    assert_equal(@todos, @list.to_a)
    assert_equal(@todo1, @list.remove_at(0))
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_to_s
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT
    
    assert_equal(output, @list.to_s)
  end

  def test_to_s_marked_done
    @list.mark_done_at(1)
    assert_equal(true, @list.item_at(1).done?)
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [X] Clean room
    [ ] Go to gym
    OUTPUT
    assert_equal(output, @list.to_s)
  end

  def test_to_s_all_done
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    @list.done!
    assert_equal(output, @list.to_s)
  end

  def test_each
    arr = []
    @list.each { |todo| arr << todo }
    assert_equal(@todos, arr)
  end
end