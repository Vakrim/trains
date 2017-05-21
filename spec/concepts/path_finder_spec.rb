require 'spec_helper';

RSpec.describe PathFinder do
  it 'finds paths' do
    start = RailNode.create_at Vector[0, 0]
    mid = RailNode.create_at Vector[1, 0]
    finish = RailNode.create_at Vector[2, 0]

    RailsBuilder.new.build(start, mid, finish)

    pf = PathFinder.new(start, finish)
    expect(pf.find).to eq [start, mid, finish]
  end

  it 'finds best paths' do
    start = RailNode.create_at Vector[0, 0]
    finish = RailNode.create_at Vector[3, 3]

    mid_a1 = RailNode.create_at Vector[3, 0]

    mid_b1 = RailNode.create_at Vector[1, 1]
    mid_b2 = RailNode.create_at Vector[2, 2]


    RailsBuilder.new.build(start, mid_a1, finish)

    RailsBuilder.new.build(start, mid_b1, mid_b2, finish)

    pf = PathFinder.new(start, finish)
    expect(pf.find).to eq [start, mid_b1, mid_b2, finish]
  end

  it 'returns error if it can\' find paths' do
    a = RailNode.create_at Vector[0, 0]
    b = RailNode.create_at Vector[1, 0]
    c = RailNode.create_at Vector[2, 0]

    Rail.create(a, b)

    pf = PathFinder.new(a, c)
    expect { pf.find }.to raise_error PathFinder::PathNotFound
  end
end
