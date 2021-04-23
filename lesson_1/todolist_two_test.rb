require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'todolist_two'

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
    assert_equal @todos, @list.to_a
  end

  def test_size
    assert_equal 3, @list.size
  end

  def test_first
    assert_equal @todo1, @list.first
  end

  def test_last
    assert_equal @todo3, @list.last
  end

  def test_shift
    removed_todo = @list.shift
    assert_equal @todo1, removed_todo
    assert_equal @todo2, @list.first
    assert_equal 2, @list.size
    assert_equal [@todo2, @todo3], @list.to_a
  end

  def test_pop
    removed_todo = @list.pop
    assert_equal @todo3, removed_todo
    assert_equal @todo2, @list.last
    assert_equal 2, @list.size
    assert_equal [@todo1, @todo2], @list.to_a
  end

  def test_done?
    assert_equal false, @list.done?
    @list.done!
    assert_equal true, @list.done?
  end

  def test_invalid_input
    assert_raises(TypeError) { @list.add(1) }
    assert_raises(TypeError) { @list.add("Wash car") }
  end

  def test_add
    new_todo = Todo.new("Wash car")
    @list.add(new_todo)
    assert_equal [@todo1, @todo2, @todo3, new_todo], @list.to_a
  end

  def test_shovel_add_alias
    new_todo = Todo.new("Wash car")
    @list << new_todo
    assert_equal [@todo1, @todo2, @todo3, new_todo], @list.to_a
  end

  def test_item_at
    assert_equal @todo2, @list.item_at(1)
    assert_raises(IndexError) { @list.item_at(100) }
  end

  def test_mark_done_at
    assert_raises(IndexError) { @list.mark_done_at(100) }
    assert_equal(false, @list.first.done?)
    @list.mark_done_at(0)
    assert_equal(true, @list.first.done?)
    assert_equal(false, @list.last.done?)
  end

  def test_mark_undone_at
    assert_raises(IndexError) { @list.mark_undone_at(101) }
    @list.mark_done_at(0)
    assert_equal(true, @list.first.done?)
    assert_equal(false, @list.done?)
    @list.mark_undone_at(0)
    assert_equal(false, @list.first.done?)
  end

  def test_done!
    assert_equal(false, @list.done?)
    @list.done!
    assert_equal(true, @list.done?)
    assert_equal(true, @list.first.done?)
    assert_equal(true, @list.last.done?)
  end

  def test_remove_at
    assert_raises(IndexError) { @list.remove_at(100) }
    assert_equal(@todos, @list.to_a)
    @list.remove_at(1)
    assert_equal([@todo1, @todo3], @list.to_a)
  end

  def test_to_s
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT
  
    assert_equal(output, @list.to_s)
  end

  def test_to_s_one_todo_marked_done
    @list.mark_done_at(1)
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [X] Clean room
    [ ] Go to gym
    OUTPUT
  
    assert_equal(output, @list.to_s)
  end

  def test_to_s_oall_todos_marked_done
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
    assert_equal([@todo1, @todo2, @todo3], arr)
  end

  def test_each_returns_caller
    assert_same(@list, @list.each { |todo| "nothing" })
  end

  def test_select
    @list.mark_done_at(1)
    new_list = @list.select { |todo| !todo.done? }
    assert_equal([@todo1, @todo3] , new_list.to_a)
    assert_instance_of(TodoList, new_list)
  end

  def test_find_by_title
    assert_nil(@list.find_by_title("Wacky Man"))
    assert_equal(@todo3, @list.find_by_title("Go to gym"))
  end

  def test_all_done
    assert_equal(false, @list.done?)
    @list.first.done!
    @list.last.done!
    new_list = @list.all_done
    assert_equal([@todo1, @todo3], new_list.to_a)
  end

  def test_all_not_done
    assert_equal(false, @list.done?)
    @list.first.done!
    @list.last.done!
    new_list = @list.all_not_done
    assert_equal([@todo2], new_list.to_a)
  end

  def test_mark_done
    assert_equal(false, @list.first.done?)
    @list.mark_done("Buy milk")
    assert_equal(true, @list.first.done?)
  end

  def test_mark_all_done
    assert_equal(false, @list.done?)
    @list.mark_all_done
    assert_equal(true, @list.done?)
    assert_equal(true, @list.first.done?)
    assert_equal(true, @list.last.done?)
  end
  
  def test_mark_all_undone
    @list.mark_all_done
    assert_equal(true, @list.done?)
    @list.mark_all_undone
    assert_equal(false, @list.done?)
    assert_equal(false, @list.first.done?)
    assert_equal(false, @list.last.done?)
  end
end