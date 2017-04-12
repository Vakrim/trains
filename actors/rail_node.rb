class RailNode < Actor

  attr_accessor :position

  def self.create_at(position)
    new position: position
  end

  def initialize(options = {})
    super
    @position = options.fetch :position
  end

  def draw
    color = Gosu::Color::WHITE
    Gosu::draw_rect(position[0] - 2, position[1] - 2, 4, 4, color)
  end
end