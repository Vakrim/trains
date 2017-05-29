require 'spec_helper';

describe 'game' do
  it 'runs game for 10000 steps' do
    require './maps/map_02.rb'

    tick = 1/60
    
    10000.times {
      Actor.each { |a| a.update tick }
    }
  end
end
