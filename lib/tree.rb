# frozen_string_literal: true

require_relative 'node'

# Binary Search Tree
class Tree
  attr_reader :root
  def initialize(arr = [])
    @root = build_tree(arr)
  end

  def build_tree(arr)
    sorted = arr.sort.uniq
    @root = sorted_array_to_bst(sorted, 0, arr.length - 1)
  end

  def sorted_array_to_bst(arr, first_idx, last_idx)
    return nil if first_idx > last_idx

    mid = (first_idx + last_idx) / 2
    node = Node.new(arr[mid])
    node.left = sorted_array_to_bst(arr, first_idx, mid - 1)
    node.right = sorted_array_to_bst(arr, mid + 1, last_idx)
    node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value)
    new_node = Node.new(value)
    @root = insert_rec(@root, new_node)
  end

  def insert_rec(current, new_node)
    if current.nil?
      current = new_node
      return current
    end

    case new_node.data <=> current.data
    when -1 then current.left = insert_rec(current.left, new_node)
    when 1 then current.right = insert_rec(current.right, new_node)
    else return nil
    end

    current
  end

  def delete(value)

  end
end
