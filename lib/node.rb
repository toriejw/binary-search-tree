require_relative './null_node'

class Node
  attr_accessor :data, :left_node, :right_node

  def initialize(data, left_node = NullNode::DEFAULT, right_node = NullNode::DEFAULT)
    @data = data
    @left_node = left_node
    @right_node = right_node
  end

end
