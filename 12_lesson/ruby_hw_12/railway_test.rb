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
alm_osk.get_stations

talgo_01 = Train.new("01A", "P", 19)

talgo_01.accept_route(alm_osk)

almaty.get_trains
aqtau.get_trains
nur_sultan.get_trains
oskemen.get_trains

talgo_01.move_train("fwd")

talgo_01.get_station("current")
talgo_01.get_station("next")
talgo_01.get_station("previous")

almaty.get_trains
aqtau.get_trains
nur_sultan.get_trains
oskemen.get_trains

talgo_01.move_train("backwd")

almaty.get_trains
aqtau.get_trains
nur_sultan.get_trains
oskemen.get_trains
