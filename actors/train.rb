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
    (direction_sym == :finish && @d > rail.length) ||
    (direction_sym == :start && @d < 0)
  end

  def direction_sym
    @direction > 0 ? :finish : :start
  end

  def select_new_rail

    new_rail_pair = rail.next_rails(direction_sym).sample

    return unless new_rail_pair
    self.rail = new_rail_pair[:rail]

    if new_rail_pair[:type_of_node] == :start
      @d = 0
      @direction = 1
    elsif new_rail_pair[:type_of_node] == :finish
      @d = rail.length
      @direction = -1
    else
      raise StandardError.new 'Unexpected type of node'
    end
  end
end
