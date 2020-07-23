RSpec.describe Station do
  context 'with valid params' do
    let!(:station) { Station.new('almaty') }
    let!(:train) { PassengerTrain.new('001P') }
    let!(:station2) { Station.new('astana') }
    let!(:train2) { CargoTrain.new('002C') }

    before { station.accept_train(train) }

    describe '#name' do
      it 'returns station name' do
        expect(station.name).to eq 'almaty'
      end
    end

    describe '#accept_train' do
      it 'adds train' do
        expect(station.trains.include?(train)).to eq true
      end
    end

    describe '#remove_train' do
      it 'removes train' do
        station.remove_train(train)

        expect(station.trains.include?(train)).to eq false
      end
    end

    describe '#trains' do
      it 'returns trains' do
        station.accept_train(train2)

        expect(station.trains).to eq [train, train2]
      end
    end

    describe '#trains_name' do
      it 'returns trains names' do
        station.accept_train(train2)

        expect(station.trains_name).to eq "#{train.name}, #{train2.name}"
      end
    end
    
    describe '#send_train' do
      it 'sends train' do
        station.send_train(train, station2)

        expect(station.trains.include?(train)).to eq false
        expect(station2.trains.include?(train)).to eq true
      end
    end

    describe '#each_train 'do
      it 'iterates each train' do
        station.accept_train(train2)
        trains = []

        station.each_train { |train| trains << train }
        expect(trains).to eq [train, train2]
      end
    end
  end

  context 'with invalid params' do
    it 'did not valid' do
      expect(Station.new('').valid?).to eq false
    end
  end
end
