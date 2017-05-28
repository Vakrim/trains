300.times do |n|
  RailNode.create_at Vector[rand(640), rand(480)]
end

RailNode.each do |node|
  node.nearest(3).each do |target_node|
    Rail.create(target_node, node)
  end
end

3.times {
  Train.new(rail: Rail.all.sample)
}
