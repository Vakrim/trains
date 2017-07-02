class RailDirection

  attr_reader :rail, :direction

  def initialize(rail, direction)
    @rail = rail
    @direction = direction
  end

  def eql?(other)
    other.is_a?(RailDirection) &&
      other.rail == rail &&
      other.direction == direction
  end

  def ==(other)
    eql? other
  end

  def hash
    [rail, direction].hash
  end

  def next_rails
    end_node.next_rails(rail)
  end

  def direction_vector
    rail.direction * (direction == ENDPOINT_B ? 1 : -1)
  end

  def end_node
    rail.node(@direction)
  end

  def length
    rail.length
  end
end
