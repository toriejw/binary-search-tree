require_relative './node'
require_relative './null_node'

class BSTree
  attr_accessor :head

  def initialize(head = NullNode::DEFAULT)
    @head = head
  end

  def insert(data, node = head)
    if node.data.nil?
      self.head = Node.new(data) if node == head
      node = Node.new(data) if node != head
    else
      if data > node.data
        if node.right_node.data.nil?
          node.right_node = Node.new(data)
        else
          insert(data, node.right_node)
        end
      elsif data <= node.data
        if node.left_node.data.nil?
          node.left_node = Node.new(data)
        else
          insert(data, node.left_node)
        end
      end
    end
    self
  end

  def include?(value, node = head)
    return false if node.data.nil?

    if node.data == value
      true
    elsif value > node.data
      return true if node.right_node.data == value
      include?(value, node.right_node)
    elsif value < node.data
      return true if node.left_node.data == value
      include?(value, node.left_node)
    end
  end

  def maximum(node = head)
    return node.data if node.right_node.data.nil?
    maximum(node.right_node)
  end

  def minimum(node = head)
    return node.data if node.left_node.data.nil?
    minimum(node.left_node)
  end

  def depth_of(value)
    return nil unless include?(value)

    depth = 0
    node = head

    loop do
      if node.data == value
        return depth + 1
      elsif value > node.data
        depth += 1
        node = node.right_node
      else
        depth += 1
        node = node.left_node
      end
    end
  end

  def sort
    sorted = []
    traverse_tree(sorted)
  end

  def traverse_tree(values, node = head)
    traverse_tree(values, node.left_node) if node.left_node
    values << node.data unless node.data.nil?
    traverse_tree(values, node.right_node) if node.right_node

    values
  end

  def delete(value, node = head)
    return unless include?(value)

    if node.data == value
      node.data = nil
      repair_tree_from(node)
    else
      delete(value, node.left_node) if value < node.data
      delete(value, node.right_node) if value > node.data
    end
  end

  def repair_tree_from(node)
    to_be_inserted = []
    to_be_inserted = traverse_tree(to_be_inserted, node)

    to_be_inserted.each do |value|
      insert(value)
    end
  end
end
