require 'spec_helper';

RSpec.describe RailDirection do
  describe '#next_rails' do
    it 'returns array of RailDirection rails' do
      a = RailNode.create_at Vector[0, 0]
      b = RailNode.create_at Vector[1, 0]
      c = RailNode.create_at Vector[1, 1]
      d = RailNode.create_at Vector[1, -1]
      e = RailNode.create_at Vector[2, 0]

      ab = Rail.create(a, b)
      bc = Rail.create(b, c)
      bd = Rail.create(b, d)
      eb = Rail.create(e, b)

      rd = RailDirection.new(ab, :finish)
      next_rails = rd.next_rails

      expect(next_rails).to include RailDirection.new(bc, :finish)
      expect(next_rails).to include RailDirection.new(bd, :finish)
      expect(next_rails).to include RailDirection.new(eb, :start)
    end
  end
end
