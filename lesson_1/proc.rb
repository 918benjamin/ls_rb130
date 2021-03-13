def my_method
  yield(2)
end

# One line
# Turns the symbol :to_s into a Proc, then & turns the Proc into a block
# p my_method(&:to_s)

# Two lines
a_proc = :to_s.to_proc # Explicitly call the to_proc on the symbol
p my_method(&a_proc)   # Convert Proc to block, the pass block in