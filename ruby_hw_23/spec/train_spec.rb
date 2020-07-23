RSpec.describe Train do
  let!(:train) { Train.new('777T') }
  let!(:station1) { Station.new('station1') }
  let!(:station2) { Station.new('station2') }
  let!(:route) { Route.new(station1, station2) }
  let!(:railcar) { railcar = PassengerCar.new(25) }


  before { train.accept_route(route) }

  describe '#number' do
    it 'returns train number' do
      expect(train.number).to eq '777T'
    end
  end

  describe '#rail_cars' do
    it 'returns railcars' do
      expect(train.rail_cars).to eq []
    end
  end

  describe '#current_speed' do
    it 'returns current_speed' do
      expect(train.current_speed).to eq 0
    end
  end

  describe '#attach_car' do
    it 'attach railcar' do
      train.attach_car(railcar)

      expect(train.rail_cars.size).to eq 1
      expect(train.rail_cars.include?(railcar)).to eq true
    end
  end

  describe '#detach_car' do
    it 'detaches lcar' do
      train.detach_car
      
      expect(train.rail_cars.size).to eq 0
      expect(train.rail_cars.include?(railcar)).to eq false
    end
  end

  describe '#accept_route' do
    it 'accepts route' do
      route2 = Route.new(station2, station1)
      train.accept_route(route2)

      expect(train.current_station).to eq station2
    end
  end

  describe '#travel_forward' do
    it 'moves train forward' do
      train.travel_forward

      expect(train.current_station).to eq station2
    end
  end

  describe '#travel_backward' do
    it 'moves train forward' do
      train.travel_forward
      train.travel_backward

      expect(train.current_station).to eq station1
    end
  end

  describe '#current_station' do
    it 'returns current station' do
      expect(train.current_station).to eq station1
    end
  end
  
  describe '#previous_station' do
    it 'returns previuos station' do
      train.travel_forward

      expect(train.previous_station).to eq station1
    end
  end

  describe '#next_station' do
    it 'returns next station' do
      expect(train.next_station).to eq station2
    end
  end

  describe '#cars_amount' do
    it 'returns railcars amount' do
      railcar2 = PassengerCar.new(25)
      train.attach_car(railcar)
      train.attach_car(railcar2)

      expect(train.cars_amount).to eq 2
    end
  end

  describe '#speed_up' do
    it 'increases train speed' do
      train.speed_up

      expect(train.current_speed).to eq 10
    end
  end

  describe '#stop_train' do
    it 'stops train' do
      train.stop_train

      expect(train.current_speed).to eq 0
    end
  end

  describe '#name' do
    it 'returns train name' do
      train3 = PassengerTrain.new('005P')
      train4 = CargoTrain.new('010C')
      
      expect(train3.name).to eq '005P(Passenger)'
      expect(train4.name).to eq '010C(Cargo)'
    end
  end

  describe '#each_rail_car' do
    it 'iterates each railcar' do
      railcar2 = PassengerCar.new(25)
      train.attach_car(railcar)
      train.attach_car(railcar2)
      railcars = []

      train.each_rail_car { |car| railcars << car }
      expect(railcars).to eq [railcar, railcar2]
    end
  end
end
