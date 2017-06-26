class Vector
  def rotate(angle)
    Vector[
      self[0] * Math.cos(angle) - self[1] * Math.sin(angle),
      self[0] * Math.sin(angle) + self[1] * Math.cos(angle)
    ]
  end
end
