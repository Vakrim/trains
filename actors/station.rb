class Station < Actor

  attr_reader :rail_direction

  def initialize(rail_direction)
    super
    @rail_direction = rail_direction
  end

  def draw
    draw_arrow(position, rail_direction.direction_vector)
  end

  def position
    rail_direction.end_node.position
  end

  private

  def draw_arrow(position, vector)
    color = Gosu::Color::WHITE
    a = position
    b = position + vector.rotate(Math::PI*5/6) * 10
    c = position + vector.rotate(-Math::PI*5/6) * 10

    Gosu::draw_line(a[0], a[1], color, b[0], b[1], color)
    Gosu::draw_line(a[0], a[1], color, c[0], c[1], color)
    Gosu::draw_line(b[0], b[1], color, c[0], c[1], color)
  end
end
