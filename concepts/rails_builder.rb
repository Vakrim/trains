class RailsBuilder

  attr_reader :nodes

  def start_at(position_or_node)
    @start = get_node position_or_node
    @finish = @start
    @nodes = Set.new([@start])
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
    extend_to(@finish.position + vector)
    self
  end

  def extend_to(position_or_node)
    new_finish = get_node(position_or_node)
    @nodes.add new_finish
    Rail.new({
      start: @finish,
      finish: new_finish
    })
    @finish = new_finish
    self
  end

  private

  def get_node(position_or_node)
    return position_or_node if position_or_node.is_a? RailNode
    return RailNode.create_at position_or_node
  end
end
