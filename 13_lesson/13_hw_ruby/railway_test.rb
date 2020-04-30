load "train.rb"
load "station.rb"
load "route.rb"
load "rail_car.rb"
load "cargo_train.rb"
load "passenger_train.rb"

talgo01 = PassengerTrain.new("001-P")
dhl01 = CargoTrain.new("001-C")

31.times do
  talgo01.attach_car(PassengerCar.new(50))
  dhl01.attach_car(FreightCar.new(25_000))
end

almaty = Station.new("Almaty 1")
aqtau = Station.new("Mangystau")
nur_sultan = Station.new("Nur Zhol")
oskemen = Station.new("Oskemen 1")

alm_osk = Route.new(almaty, oskemen)
alm_osk.add_station(aqtau)
alm_osk.add_station(nur_sultan)
alm_osk.delete_station(aqtau)
alm_osk.add_station(aqtau)
puts alm_osk.get_stations

talgo01.accept_route(alm_osk)

puts almaty.get_trains
puts aqtau.get_trains
puts nur_sultan.get_trains
puts oskemen.get_trains

talgo01.travel_forward

puts talgo01.current_station
puts talgo01.next_station
puts talgo01.previous_station

puts almaty.get_trains
puts aqtau.get_trains
puts nur_sultan.get_trains
puts oskemen.get_trains

talgo01.travel_backward

puts almaty.get_trains
puts aqtau.get_trains
puts nur_sultan.get_trains
puts oskemen.get_trains
