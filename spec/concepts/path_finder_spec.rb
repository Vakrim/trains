require 'spec_helper';

RSpec.describe PathFinder do
  it 'finds paths' do
    start = RailNode.create_at Vector[0, 0]
    mid = RailNode.create_at Vector[1, 0]
    finish = RailNode.create_at Vector[2, 0]

    start_rail, *rest, finish_rail = RailsBuilder.new.build(start, mid, finish)

    pf = PathFinder.new(
      RailDirection.new(start_rail, ENDPOINT_B),
      RailDirection.new(finish_rail, ENDPOINT_B),
    )
    expect(pf.find.map(&:end_node)).to eq [mid, finish]
  end

  it 'finds best paths' do
    pending 'not ready for directioned rails'
    start = RailNode.create_at Vector[0, 0]
    finish = RailNode.create_at Vector[3, 3]

    mid_a1 = RailNode.create_at Vector[3, 0]

    mid_b1 = RailNode.create_at Vector[1, 1]
    mid_b2 = RailNode.create_at Vector[2, 2]


    RailsBuilder.new.build(start, mid_a1, finish)

    RailsBuilder.new.build(start, mid_b1, mid_b2, finish)

    pf = PathFinder.new(
      RailDirection.new(start, ENDPOINT_B),
      RailDirection.new(finish, ENDPOINT_B),
    )
    expect(pf.find).to eq [start, mid_b1, mid_b2, finish]
  end

  it 'returns error if it can\'t find paths' do
    a = RailNode.create_at Vector[0, 0]
    b = RailNode.create_at Vector[1, 0]
    c = RailNode.create_at Vector[2, 0]
    d = RailNode.create_at Vector[3, 0]

    start = Rail.create(a, b)
    finish = Rail.create(c, d)

    pf = PathFinder.new(
      RailDirection.new(start, ENDPOINT_B),
      RailDirection.new(finish, ENDPOINT_B),
    )
    expect { pf.find }.to raise_error PathFinder::PathNotFound
  end

  it 'handles directions' do
    a = RailNode.create_at(Vector[0, 0])
    b = RailNode.create_at(Vector[1, 0])
    c = RailNode.create_at(Vector[2, 0])
    d = RailNode.create_at(Vector[3, 1])
    e = RailNode.create_at(Vector[3, -1])

    end_rail = Rail.create(a, b)
    start_rail = Rail.create(b, c)
    Rail.create(c, d)
    Rail.create(d, e)
    Rail.create(e, c)

    pf = PathFinder.new(
      RailDirection.new(start_rail, ENDPOINT_B),
      RailDirection.new(end_rail, ENDPOINT_A)
    )
    expect(pf.find.map(&:end_node)).to eq [c, d, e, c, b, a]
  end
end
