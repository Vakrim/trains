class RailDirection

  attr_reader :rail, :direction

  def initialize(rail, direction)
    @rail = rail
    @direction = direction
  end

  def ==(other)
    other.is_a?(RailDirection) &&
      other.rail == rail &&
      other.direction == direction
  end

  def next_rails
    end_node.next_rails(rail)
  end

  def end_node
    rail.node(@direction)
  end

  def length
    rail.length
  end
end
