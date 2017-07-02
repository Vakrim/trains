class PathFinder

  class PathNotFound < StandardError; end

  def initialize(endpoint_a, endpoint_b)
    @endpoint_a = endpoint_a
    @endpoint_b = endpoint_b
  end

  def find
    closed_set = Set.new []
    open_set = Set.new [@endpoint_a]
    came_from = {}

    g_score = Hash.new(Float::INFINITY)
    f_score = Hash.new(Float::INFINITY)

    g_score[@endpoint_a] = 0
    f_score[@endpoint_a] = heuristic_cost_estimate(@endpoint_a, @endpoint_b)

    while !open_set.empty? do
      current = open_set.min_by { |node| f_score[node] } # the node in open_set having the lowest f_score[] value
      if current == @endpoint_b
        return reconstruct_path(came_from, current)
      end

      open_set.delete(current)
      closed_set.add(current)

      current.next_rails.each do |rail|
        next if closed_set.include? rail

        tentative_g_score = g_score[current] + rail.length

        if !open_set.include?(rail)
          open_set.add(rail)
        elsif tentative_g_score >= g_score[rail]
          next
        end

        came_from[rail] = current
        g_score[rail] = tentative_g_score
        f_score[rail] = g_score[rail] + heuristic_cost_estimate(rail, @endpoint_b)
      end
    end

    raise PathNotFound
  end

  def heuristic_cost_estimate(a, b)
    (a.end_node.position - b.end_node.position).r
  end

  def reconstruct_path(came_from, current)
    Path.new do |path|
      path.prepend current
      while came_from.keys.include?(current) do
        current = came_from[current]
        path.prepend current
      end
    end
  end
end
