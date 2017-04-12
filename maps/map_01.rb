p1 = RailNode.new(x: 30, y: 30)
p2 = RailNode.new(x: 200, y: 30)
p3 = RailNode.new(x: 200, y: 200)
p4 = RailNode.new(x: 300, y: 200)

r1 = Rail.new(start: p1, finish: p2)
r2 = Rail.new(start: p2, finish: p3)
r3 = Rail.new(start: p3, finish: p4)

Train.new(rail: r1)
