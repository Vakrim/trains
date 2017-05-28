class Rail < Actor

  attr_accessor :start, :finish

  def self.create(start, finish)
    return false if find { |rail| (rail.start == start && rail.finish == finish) || (rail.start == finish && rail.finish == start)  }
    new({start: start, finish: finish})
    true
  end

  def initialize(options = {})
    super
    @start = options.fetch :start
    @finish = options.fetch :finish
  end

  def draw
    color1 = Gosu::Color::WHITE
    color2 = Gosu::Color::WHITE

    Gosu::draw_line(
      start.position[0],
      start.position[1],
      color1,
      finish.position[0],
      finish.position[1],
      color2
    )
  end

  def length
    @length ||= (finish.position - start.position).magnitude
  end

  def direction
    @direction ||= (finish.position - start.position).normalize
  end

  def position_at(d)
    start.position + direction * d
  end

  def type_of_node(node)
    return :start if node == self.start
    return :finish if node == self.finish
  end

  def next_rails(node_type)
    node = {
      start: start,
      finish: finish
    }[node_type]
    node.next_rails(self)
  end
end
