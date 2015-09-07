require_relative './node'

class BSTree
  attr_accessor :head

  def initialize(head = NullNode::DEFAULT)
    @head = head
  end

  def insert(data, node = head)
    if head.data.nil?
      self.head = Node.new(data)
      return
    end

    if data > node.data
      insert_right(data, node)
    else
      insert_left(data, node)
    end
    self
  end

  def insert_left(data, node)
    if node.left_node.data.nil?
      node.left_node = Node.new(data)
    else
      insert(data, node.left_node)
    end
  end

  def insert_right(data, node)
    if node.right_node.data.nil?
      node.right_node = Node.new(data)
    else
      insert(data, node.right_node)
    end
  end

  def include?(value, node = head)
    return false if node.data.nil?
    return true if node.data == value

    if value > node.data
      include?(value, node.right_node)
    else
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
      return depth + 1 if node.data == value
      if value > node.data
        node = node.right_node
      else
        node = node.left_node
      end
      depth += 1
    end
  end

  def sort
    sorted = []
    traverse_tree(sorted)
  end

  def traverse_tree(leaves, node = head)
    traverse_tree(leaves, node.left_node) if node.left_node
    leaves << node.data unless node.data.nil?
    traverse_tree(leaves, node.right_node) if node.right_node

    leaves
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

  def output_data
    handle = File.open("/Users/Torie/Documents/turing/module_1/projects/binary-search-tree/output.txt", "w")
    handle.write(sort)
    handle.close
  end

  def number_of_leaves
    sort.size
  end

  def import(file_name)
    handle = File.open(file_name)
    handle.each_line do |line|
      insert(line.chomp)
    end
    handle.close
  end
end
