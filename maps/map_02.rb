map = {}

(5..635).step(40).with_index do |x, xi|
  (5..475).step(40).with_index do |y, yi|
    current = map[[xi, yi]] = RailNode.create_at(Vector[x, y])
    Rail.create(current, map[[xi - 1, yi]]) if(map[[xi - 1, yi]])
    Rail.create(current, map[[xi, yi - 1]]) if(map[[xi, yi - 1]])
  end
end

3.times {
  Train.new(rail: Rail.all.sample)
}

5.times {
  station = Station.new(RailDirection.new(Rail.all.sample, ENDPOINT_B))

  Resource.new(
    container: station,
    type: :apple
  )
}
