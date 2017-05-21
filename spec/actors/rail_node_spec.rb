require 'spec_helper';

RSpec.describe RailNode do
  it 'creates new RailNode' do
    RailNode.create_at Vector[1, 2]
    expect(RailNode.count).to eq 1
  end
end
