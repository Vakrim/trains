class Train < Actor

  attr_accessor :rail

  def initialize(options = {})
    super
    @rail = options[:rail]
    @d = 0
  end

  def draw
    pos = position
    color = Gosu::Color::RED
    Gosu::draw_rect(pos[:x] - 2, pos[:y] - 2, 4, 4, color)
  end

  def position
    rail.position_at(@d)
  end

  def update(tick)
    @d = @d + tick * 20
  end
end
