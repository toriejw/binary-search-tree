require_relative '../lib/node'
require_relative '../lib/null_node'

class NodeTest < MiniTest::Test

  def setup
    @node = Node.new(1)
  end

  def test_node_has_data
    assert_equal 1, @node.data
  end

  def test_node_data_can_be_any_object
    @node.data = [1, 2, 3]
    assert_equal [1, 2, 3], @node.data
    new_node = Node.new('b')
    @node.data = new_node
    assert_equal new_node, @node.data
  end

  def test_node_has_a_left_node_that_defaults_to_null
    assert_equal NullNode::DEFAULT, @node.left_node
  end

  def test_node_has_a_right_node_that_defaults_to_null
    assert_equal NullNode::DEFAULT, @node.right_node
  end
end
