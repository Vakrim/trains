class Path < Array

  def initialize(&block)
    super()
    @cursor = 0
    yield self
  end

  def prepend(rail)
    self.unshift rail
  end

  def next_rail_direction
    @cursor = @cursor + 1
    peek_rail_direction
  end

  def peek_rail_direction
    self[@cursor]
  end

  def at_end?
    length == @cursor
  end
end
