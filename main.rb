# frozen_string_literal: true

require_relative 'lib/node'
require_relative 'lib/tree'

random_nums = (Array.new(15) { rand(1..100) })
tree = Tree.new(random_nums)
tree.pretty_print
puts "Balanced? #{tree.balanced?}"

print_array = []
tree.level_order { |node| print_array << node.data }
puts "Level order: #{print_array}"
print_array.clear
tree.preorder { |node| print_array << node.data }
puts "Preorder: #{print_array}"
print_array.clear
tree.postorder { |node| print_array << node.data }
puts "Postorder: #{print_array}"
print_array.clear
tree.inorder { |node| print_array << node.data }
puts "Inorder: #{print_array}"
print_array.clear

puts 'Adding values 101-114...'
i = 101
while i < 115
  tree.insert(i)
  i += 1
end
tree.pretty_print
puts "Balanced? #{tree.balanced?}"
puts 'Rebalancing...'
tree.rebalance
tree.pretty_print
puts "Balanced now? #{tree.balanced?}"

tree.level_order { |node| print_array << node.data }
puts "Level order: #{print_array}"
print_array.clear
tree.preorder { |node| print_array << node.data }
puts "Preorder: #{print_array}"
print_array.clear
tree.postorder { |node| print_array << node.data }
puts "Postorder: #{print_array}"
print_array.clear
tree.inorder { |node| print_array << node.data }
puts "Inorder: #{print_array}"
print_array.clear