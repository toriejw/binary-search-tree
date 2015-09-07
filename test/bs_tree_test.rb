require_relative '../lib/bs_tree'

class BSTreeTest < Minitest::Test
  def setup
    @tree = BSTree.new
    @tree.insert(8)
  end

  def test_has_a_head_that_defaults_to_null_node
    assert_equal NullNode::DEFAULT, BSTree.new.head
    assert_equal 8, @tree.head.data
  end

  def test_head_doesnt_change_when_new_nodes_added
    @tree.insert(5).insert(4).insert(10)
    assert_equal 8,  @tree.head.data
  end

  def test_can_add_nodes
    @tree.insert(5).insert(4).insert(10).insert(7)
    assert_equal 5,  @tree.head.left_node.data
    assert_equal 4,  @tree.head.left_node.left_node.data
    assert_equal 10, @tree.head.right_node.data
    assert_equal 7,  @tree.head.left_node.right_node.data
  end

  def test_can_add_node_with_same_data_as_existing_node
    @tree.insert(5).insert(4).insert(10).insert(10)
    assert_equal 10, @tree.head.right_node.left_node.data
  end

  def test_can_determine_if_it_contains_a_given_value
    @tree.insert(5).insert(10).insert(7).insert(20).insert(3)
    assert @tree.include? 5
    assert @tree.include? 20
    refute @tree.include? 12
  end

  def test_knows_its_max_value
    @tree.insert(5).insert(10)
    assert_equal 10, @tree.maximum
    @tree.insert(7).insert(20).insert(17)
    assert_equal 20, @tree.maximum
  end

  def test_knows_its_min_value
    @tree.insert(5).insert(10)
    assert_equal 5, @tree.minimum
    @tree.insert(7).insert(2).insert(17)
    assert_equal 2, @tree.minimum
  end

  def test_knows_min_and_max_value_if_only_head_exists
    assert_equal 8, @tree.minimum
    assert_equal 8, @tree.maximum
  end

  def test_knows_depth_of_a_given_node
    @tree.insert(5)
    assert_equal 2, @tree.depth_of(5)

    @tree.insert(2).insert(1)
    assert_equal 4, @tree.depth_of(1)
  end

  def test_returns_nil_for_depth_of_if_value_not_in_tree
    @tree.insert(5).insert(2).insert(1)
    refute @tree.depth_of 30
  end

  def test_can_return_sorted_array
    @tree.insert(1).insert(2).insert(6).insert(9)
    assert_equal [1, 2, 6, 8, 9], @tree.sort
  end

  def test_can_return_sorted_array_with_repeated_values
    @tree.insert(1).insert(2).insert(6).insert(9).insert(8)
    assert_equal [1, 2, 6, 8, 8, 9], @tree.sort
  end

  def test_can_delete_a_value
    @tree.insert(1).insert(2).insert(10).insert(9).insert(11)
    assert_equal 9, @tree.head.right_node.left_node.data
    @tree.delete(9)
    assert_equal nil, @tree.head.right_node.left_node.data
  end

  def test_tree_is_repaired_after_node_deletion
    @tree.insert(1).insert(2).insert(10).insert(9).insert(11)
    @tree.delete(10)
    assert_equal  9, @tree.head.right_node.data
    assert_equal 11, @tree.head.right_node.right_node.data

    @tree.insert(15).insert(12)
    @tree.delete(11)
    assert @tree.include?(15)
    assert @tree.include?(12)
  end

  # test for importing exporting files?

end
