class Resource < Actor

  attr_reader :type, :container

  def initialize(type:, container:)
    super
    @type = type
    @container = container
  end

  def draw
    pos = position
    color = Gosu::Color::GREEN
    Gosu::draw_rect(pos[0] - 2, pos[1] - 2, 4, 4, color)
  end

  def position
    container.position
  end
end
