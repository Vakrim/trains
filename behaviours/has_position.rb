module HasPosition
  module ClassMethods
    def nearest(position, n = nil)
      min_by(n) { |actor| (actor.position - position).magnitude }
    end
  end

  def nearest(n)
    self.class.nearest(position, n + 1).select { |actor| actor != self }
  end
end
