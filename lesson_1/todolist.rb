class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done = otherTodo.done
  end
end

# Examples of how to use Todo objects
# todo1 = Todo.new("Buy milk")
# todo2 = Todo.new("Clean room")
# todo3 = Todo.new("Go to gym")

# puts todo1 # [] Buy milk
# puts todo2 # [] Clean room
# puts todo3 # [] Go to gym

# todo1.done!
# puts ""

# puts todo1 # [] Buy milk
# puts todo2 # [] Clean room
# puts todo3 # [] Go to gym

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(todo)
    if todo.class == Todo
      todos << todo
    else
      raise TypeError, "Can only add Todo objects"
    end
    todos
  end

  alias_method :<<, :add

  def size
    todos.size
  end

  def first
    todos.first
  end

  def last
    todos.last
  end

  def to_a
    todos.clone
  end

  def done?
    todos.all? { |todo| todo.done? }
  end

  def item_at(index)
    todos.fetch(index)
  end

  def mark_done_at(index)
    item_at(index).done!
  end

  def mark_undone_at(index)
    item_at(index).undone!
  end

  def done!
    todos.each do |todo|
      todo.done!
    end
  end

  def shift
    todos.shift
  end

  def pop
    todos.pop
  end

  def remove_at(index)
    item_at(index)
    todos.delete_at(index)
  end

  def to_s
    puts " ---- #{title} ----"
    todos.each do |todo|
      puts todo
    end
  end

  private

  attr_accessor :todos
end

# Make this code work by implementing the rest of the class above
todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")
list = TodoList.new("Today's Todos")

# ---- Adding to the list ----

# add
# list.add(todo1)  # adds todo1 to the end of list, returns list
# list.add(todo2)  # same with todo2
# list.add(todo3)  # same with todo3
# list.add(1)      # raises TypeError with message "Can only add Todo objects"

# << should implement the same behavior as add
list << todo1    # adds todo1 to the end of list, returns list
list << todo2    # same with todo2
list << todo3    # same with todo3
# list << 1        # raises TypeError with message "Can only add Todo objects"

# ---- Interrogating the list ---

# size
# p list.size        # 3

# first
# p list.first       # returns todo1, which is the first item in the list

# last
# p list.last        # returns todo3, which is the last item in the list

# to_a
# p list.to_a        # returns an array of all items in the list

# done?
# p list.done?       # returns true if all todos in the list are done, otherwise false

# ---- Retrieving an item in the list ----

# item_at
# list.item_at         # raises ArgumentError
# p list.item_at(1)    # returns 2nd item in list (zero based index)
# p list.item_at(100)  # raises IndexError

# ---- Marking items in the list ----

# mark_done_at
# list.mark_done_at               # raises ArgumentError
# p list.mark_done_at(1)          # marks the 2nd item as done
# list.mark_done_at(100)          # raises IndexError

# mark_undone_at
# list.mark_undone_at             # raises ArgumentError
# p list.mark_undone_at(1)          # marks the 2nd item as not done,
# list.mark_undone_at(100)        # raises IndexError

# done!
# list.done!                      # marks all items as done


# ---- Deleting from the list -----

# shift
# p list.shift                      # removes and returns the first item in list

# pop
# p list.pop                        # removes and returns the last item in list

# remove_at
# list.remove_at                  # raises ArgumentError
# p list.remove_at(1)               # removes and returns the 2nd item
# list.remove_at(100)             # raises IndexError

# ---- Outputting the list -----

# to_s
list.to_s                      # returns string representation of the list

# ---- Today's Todos ----
# [ ] Buy milk
# [ ] Clean room
# [ ] Go to gym

# or, if any todos are done

# ---- Today's Todos ----
# [ ] Buy milk
# [X] Clean room
# [ ] Go to gym
