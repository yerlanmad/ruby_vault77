load "train.rb"
load "station.rb"
load "route.rb"

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

talgo01 = Train.new("01A", "P", 19)

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
