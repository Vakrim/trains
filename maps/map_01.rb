rb = RailsBuilder.new

# rb.start_at(Vector[30, 30])
#   .extend_by(Vector[30, 0])
#   .extend_by(Vector[30, 0])
#   .extend_by(Vector[30, 0])
#   .extend_by(Vector[30, 0])
#   .extend_by(Vector[30, 0])
#   .extend_by(Vector[30, 0])

300.times do |n|
  RailNode.create_at Vector[rand(640), rand(480)]
end

RailNode.each do |node|
  node.nearest(3).each do |target_node|
    Rail.create(node, target_node)
    Rail.create(target_node, node)
  end
end

3.times {
  Train.new(rail: Rail.all.sample)
}
