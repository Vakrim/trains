class Path < Array

  def initialize(&block)
    super()
    yield self
  end

  def prepend(rail)
    self.unshift rail
  end
end
