require_relative '../lib/null_node'

class NullNodeTest < Minitest::Test
  def setup
    @null_node = NullNode.new
  end

  def test_node_has_data_equal_to_nil
    assert_equal nil, @null_node.data
  end
end
