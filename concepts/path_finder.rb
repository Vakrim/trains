class PathFinder

  class PathNotFound < StandardError; end

  def initialize(start, finish)
    @start = start
    @finish = finish
  end

  def find
    closed_set = Set.new []
    open_set = Set.new [@start]
    came_from = {}

    g_score = Hash.new(Float::INFINITY)
    f_score = Hash.new(Float::INFINITY)

    g_score[@start] = 0
    f_score[@start] = heuristic_cost_estimate(@start, @finish)

    while !open_set.empty? do
      current = open_set.min_by { |node| f_score[node] } # the node in open_set having the lowest f_score[] value
      if current == @finish
        return reconstruct_path(came_from, current)
      end

      open_set.delete(current)
      closed_set.add(current)

      current.next_rails.each do |rail|
        continue if closed_set.include? rail

        tentative_g_score = g_score[current] + rail.length

        if !open_set.include?(rail)
          open_set.add(rail)
        elsif tentative_g_score >= g_score[rail]
          continue
        end

        came_from[rail] = current
        g_score[rail] = tentative_g_score
        f_score[rail] = g_score[rail] + heuristic_cost_estimate(rail, @finish)
      end
    end

    raise PathNotFound
  end

  def heuristic_cost_estimate(a, b)
    (a.end_node.position - b.end_node.position).r
  end

  def reconstruct_path(came_from, current)
    total_path = [current]
    while came_from.keys.include?(current)  do
      current = came_from[current]
      total_path.unshift current
    end
    total_path
  end
end
