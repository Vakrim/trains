WR = WeakRef

class WeakSet < Set
  def add(obj)
    super WeakRef.new(obj)
  end
end
