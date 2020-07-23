RSpec.describe PassengerCar do
  let!(:railcar) { PassengerCar.new(40) }
  
  before { 15.times { railcar.take_place } }

  describe '#seats_amount' do
    it 'returns seats amount' do
      expect(railcar.seats_amount).to eq 40
    end
  end

  describe '#type' do
    it 'returns type' do
      expect(railcar.type).to eq 'Passenger'
    end
  end

  describe '#occupied_seats' do
    it 'returns occupied seats' do
      expect(railcar.occupied_seats).to eq 15
    end
  end

  describe '#take_place' do
    it 'takes place' do
      railcar.take_place

      expect(railcar.occupied_seats).to eq 16
    end
  end

  describe '#empty_seats' do
    it 'returns empty seats' do
      expect(railcar.empty_seats).to eq 25
    end
  end
end
