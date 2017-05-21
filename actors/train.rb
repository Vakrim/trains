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
    Gosu::draw_rect(pos[0] - 2, pos[1] - 2, 4, 4, color)
  end

  def position
    rail.position_at(@d)
  end

  def update(tick)
    @d = @d + tick * 80
    select_new_rail if @d > rail.length
  end

  private

  def select_new_rail
    current_rail_end_node = rail.finish
    @rail = Rail.select{ |rail| rail.start == current_rail_end_node }.sample || Rail.to_a.sample
    @d = 0
  end
end
