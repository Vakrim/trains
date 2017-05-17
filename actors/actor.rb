class Actor

  @@actors = []

  def self.all
    if self == Actor
      @@actors
    else
      @@actors.select{ |actor| actor.is_a? self }
    end
  end

  def self.each(&block)
    all.each(&block)
  end

  def initialize(options = {})
    @@actors.push(self)
    @is_alive = true
    @timer = Timer.new
  end

  def update(tick); end

  def draw; end

  def alive?
    @is_alive
  end

  def exists?
    alive?
  end

  def destroy!
    @is_alive = false
    @@actors.delete self
  end
end
