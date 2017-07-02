class Train < Actor

  attr_accessor :rail

  def initialize(rail:)
    super
    @rail = rail
    @d = 0
    @direction = 1
    @target = nil
    @path = nil
    select_new_station
  end

  def draw
    pos = position
    color = Gosu::Color::RED
    Gosu::draw_rect(pos[0] - 2, pos[1] - 2, 4, 4, color)

    if(@target)
      Gosu::draw_line(pos[0], pos[1], color, @target.position[0], @target.position[1], color)
    end
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

  def rail_direction
    RailDirection.new(rail, direction_sym)
  end

  private

  def at_end_of_rail?
    (direction_sym == ENDPOINT_B && @d > rail.length) ||
    (direction_sym == ENDPOINT_A && @d < 0)
  end

  def direction_sym
    @direction > 0 ? ENDPOINT_B : ENDPOINT_A
  end

  def select_new_station
    @target = Station.all.sample
  end

  def select_new_rail
    if !@path
      find_path_to_target
    elsif @path.at_end?
      select_new_station
      find_path_to_target
      return
    else
      rail_direction = @path.next_rail_direction
    end

    return unless rail_direction
    self.rail = rail_direction.rail

    if rail_direction.direction == ENDPOINT_B
      @d = 0
      @direction = 1
    elsif rail_direction.direction == ENDPOINT_A
      @d = rail.length
      @direction = -1
    else
      raise StandardError.new 'Unexpected type of node'
    end
  end

  def find_path_to_target
    @path = PathFinder.new(rail_direction, @target.rail_direction).find
  end
end
