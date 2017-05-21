class Rail < Actor

  attr_accessor :start, :finish

  def self.create(start, finish)
    return if find { |rail| rail.start == start && rail.finish == finish }
    new({start: start, finish: finish})
  end

  def initialize(options = {})
    super
    @start = options.fetch :start
    @finish = options.fetch :finish
  end

  # def extend_to(x, y)
  #   new_finish = RailNode.create_at(x, y)
  #   Rail.new.tap do |r|
  #     r.start = finish
  #     r.finish = new_finish
  #   end
  # end

  def draw
    color1 = Gosu::Color::WHITE
    color2 = Gosu::Color::GREEN

    padding = Vector[direction[1], -direction[0]] * 2

    Gosu::draw_line(
      start.position[0] + padding[0],
      start.position[1] + padding[1],
      color1,
      finish.position[0] + padding[0],
      finish.position[1] + padding[1],
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
end
