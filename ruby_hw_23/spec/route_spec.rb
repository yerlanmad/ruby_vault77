RSpec.describe Route do
  let!(:station1) { Station.new('station1') }
  let!(:station2) { Station.new('station2') }
  let!(:route) { Route.new(station1, station2) }
  let(:station3) { Station.new('station3') }

  describe '#stations' do
    it 'returns stations' do
      expect(route.stations).to eq [station1, station2]
    end
  end

  describe '#name' do
    it 'returns route name' do
      expect(route.name).to eq 'station1_station2'
    end
  end

  describe '#add_station' do
    it 'add station' do
      route.add_station(station3)

      expect(route.stations).to eq [station1, station3, station2]
    end
  end
  
  describe '#delete_station' do
    it 'delete station' do
      route.add_station(station3)
      expect(route.stations).to eq [station1, station3, station2]

      route.delete_station(station3)
      expect(route.stations).to eq [station1, station2]
    end
  end

  describe '#stations_name' do
    it 'returns stations name' do
      expect(route.stations_name).to eq [station1.name, station2.name]
    end
  end
end
