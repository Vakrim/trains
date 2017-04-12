class Rail < Actor

  attr_accessor :start, :finish

  def self.create_at()
  end

  def initialize(options = {})
    super
    @start = options.fetch :start
    @finish = options.fetch :finish
  end

  def extend_to(x, y)
    new_finish = RailNode.create_at(x, y)
    Rail.new.tap do |r|
      r.start = finish
      r.finish = new_finish
    end
  end

  def draw
    color = Gosu::Color::WHITE
    Gosu::draw_line(start.position[0], start.position[1], color, finish.position[0], finish.position[1], color)
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
