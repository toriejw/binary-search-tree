class NullNode
  attr_reader :data

  def initialize
    @data = nil
  end

  DEFAULT = NullNode.new

  def left_node
    nil
  end

  def right_node
    nil
  end

end
