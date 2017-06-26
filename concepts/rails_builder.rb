class RailsBuilder

  attr_reader :nodes

  def endpoint_a_at(position_or_node)
    @endpoint_a = get_node position_or_node
    @endpoint_b = @endpoint_a
    @nodes = Set.new([@endpoint_a])
    self
  end

  def build(*positions_or_nodes)
    created_rails = []
    positions_or_nodes
      .map { |position_or_node| get_node position_or_node }
      .reduce do |prev_node, next_node|
        created_rails << Rail.create(prev_node, next_node)
        next_node
      end
    created_rails
  end

  def extend_by(vector)
    extend_to(@endpoint_b.position + vector)
    self
  end

  def extend_to(position_or_node)
    new_endpoint_b = get_node(position_or_node)
    @nodes.add new_endpoint_b
    Rail.new({
      endpoint_a: @endpoint_b,
      endpoint_b: new_endpoint_b
    })
    @endpoint_b = new_endpoint_b
    self
  end

  private

  def get_node(position_or_node)
    return position_or_node if position_or_node.is_a? RailNode
    return RailNode.create_at position_or_node
  end
end
