p1 = RailNode.create_at Vector[30, 30]
p2 = RailNode.create_at Vector[100, 30]
p3 = RailNode.create_at Vector[100, 100]
p4 = RailNode.create_at Vector[200, 100]

Rail.new(start: p1, finish: p2)
Rail.new(start: p2, finish: p3)
Rail.new(start: p2, finish: p4)
Rail.new(start: p3, finish: p4)
Rail.new(start: p4, finish: p3)
Rail.new(start: p4, finish: p1)

3.times {
  Train.new(rail: Rail.all.sample)
}
