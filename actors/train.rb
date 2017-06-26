class Train < Actor

  attr_accessor :rail

  def initialize(options = {})
    super
    @rail = options[:rail]
    @d = 0
    @direction = 1
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
    if at_end_of_rail?
      select_new_rail
    else
      @d = @d + tick * 80 * @direction
    end
  end

  private

  def at_end_of_rail?
    (direction_sym == ENDPOINT_B && @d > rail.length) ||
    (direction_sym == ENDPOINT_A && @d < 0)
  end

  def direction_sym
    @direction > 0 ? ENDPOINT_B : ENDPOINT_A
  end

  def select_new_rail
    new_rail_pair = RailDirection.new(rail, direction_sym).next_rails.sample

    return unless new_rail_pair
    self.rail = new_rail_pair.rail

    if new_rail_pair.direction == ENDPOINT_B
      @d = 0
      @direction = 1
    elsif new_rail_pair.direction == ENDPOINT_A
      @d = rail.length
      @direction = -1
    else
      raise StandardError.new 'Unexpected type of node'
    end
  end
end
