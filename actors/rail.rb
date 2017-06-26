class Rail < Actor

  attr_accessor :endpoint_a, :endpoint_b

  def self.create(endpoint_a, endpoint_b)
    return false if find { |rail| (rail.endpoint_a == endpoint_a && rail.endpoint_b == endpoint_b) || (rail.endpoint_a == endpoint_b && rail.endpoint_b == endpoint_a)  }
    new({endpoint_a: endpoint_a, endpoint_b: endpoint_b})
  end

  def initialize(endpoint_a:, endpoint_b:)
    super
    @endpoint_a = endpoint_a
    @endpoint_b = endpoint_b
  end

  def draw
    color1 = Gosu::Color::WHITE
    color2 = Gosu::Color::WHITE

    Gosu::draw_line(
      endpoint_a.position[0],
      endpoint_a.position[1],
      color1,
      endpoint_b.position[0],
      endpoint_b.position[1],
      color2
    )
  end

  def length
    @length ||= (endpoint_b.position - endpoint_a.position).magnitude
  end

  def direction
    @direction ||= (endpoint_b.position - endpoint_a.position).normalize
  end

  def position_at(d)
    endpoint_a.position + direction * d
  end

  def type_of_node(node)
    return ENDPOINT_A if node == self.endpoint_a
    return ENDPOINT_B if node == self.endpoint_b
  end

  def node(node_type)
    node = {
      ENDPOINT_A => endpoint_a,
      ENDPOINT_B => endpoint_b
    }[node_type]
  end

  def next_rails(node_type)
    node(node_type).next_rails(self)
  end
end
