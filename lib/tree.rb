# frozen_string_literal: true

require_relative 'node'
require 'pry-byebug'

# Binary Search Tree
class Tree
  attr_reader :root

  def initialize(arr = [])
    @root = build_tree(arr)
  end

  def build_tree(arr)
    sorted = arr.sort.uniq
    @root = sorted_array_to_bst(sorted, 0, sorted.length - 1)
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
    @root = delete_rec(@root, value)
    puts "Deleted #{value}."
  end

  def delete_rec(current, value)
    return current if current.nil?

    case value <=> current.data
    when -1 then current.left = delete_rec(current.left, value)
    when 1 then current.right = delete_rec(current.right, value)
    else
      current = delete_current(current)
    end
    current
  end

  def delete_current(current)
    return current.right if current.left.nil?
    return current.left if current.right.nil?

    current.data = min_value(current.right)
    current.right = delete_rec(current.right, current.data)
    current
  end

  def min_value(node)
    min_val = node.data
    while node.left
      min_val = node.left.data
      node = node.left
    end
    min_val
  end

  def find(value)
    find_rec(@root, value)
  end

  def find_rec(current, value)
    case value <=> current.data
    when 0 then current
    when -1 then find_rec(current.left, value)
    when 1 then find_rec(current.right, value)
    end
  end

  def level_order
    node_queue = []
    level_ordered = []
    node_queue << @root
    i = 0
    until node_queue.empty?
      level_ordered << node_queue.shift
      node_queue << level_ordered[i].left if level_ordered[i].left
      node_queue << level_ordered[i].right if level_ordered[i].right
      i += 1
    end
    if block_given?
      level_ordered.each { |node| yield node }
    else
      level_ordered.map(&:data)
    end
  end

  def level_order_rec(node = @root, node_queue=[], level_ordered=[], &block)
    yield node if block_given?
    level_ordered << node.data

    node_queue << node.left if node.left
    node_queue << node.right if node.right
    return level_ordered if node_queue.empty?

    level_order_rec(node_queue.shift, node_queue, level_ordered, &block)
  end

  def inorder(node = @root, inorder = [], &block)
    return inorder if node.nil?

    inorder(node.left, inorder, &block)
    yield node if block_given?
    inorder << node
    inorder(node.right, inorder, &block)
  end

  def preorder(node = @root, preordered = [], &block)
    return preordered if node.nil?

    yield node if block_given?
    preordered << node
    preorder(node.left, preordered, &block)
    preorder(node.right, preordered, &block)
  end

  def postorder(node = @root, postordered = [], &block)
    return postordered if node.nil?

    postorder(node.left, postordered, &block)
    postorder(node.right, postordered, &block)
    yield node if block_given?
    postordered << node
  end

  def height(node, distance=-1)
    return distance if node.nil?

    distance += 1
    [height(node.left, distance), height(node.right, distance)].max
  end

  
end
