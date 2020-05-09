require_relative "train"
require_relative "station"
require_relative "route"

almaty = Station.new("Almaty-1")
aqtau = Station.new("Mangystau")
nur_sultan = Station.new("Nur-Zhol")
oskemen = Station.new("Oskemen-1")

alm_osk = Route.new(almaty, oskemen)
alm_osk.add_station(aqtau)
alm_osk.add_station(nur_sultan)
alm_osk.delete_station(aqtau)
alm_osk.add_station(aqtau)
puts "Route name: #{alm_osk.name}"
puts "Route stations: #{alm_osk.stations.map(&:name).join(', ')}"

talgo01 = Train.new("01A", "P", 19)

talgo01.accept_route(alm_osk)

puts "Trains in Almaty: #{almaty.trains.map(&:number)}"
puts "Trains in NS: #{nur_sultan.trains.map(&:number)}"
puts "Trains in Aqtau: #{aqtau.trains.map(&:number)}"
puts "Trains in OSK: #{oskemen.trains.map(&:number)}\n"

puts "travel_forward"
talgo01.travel_forward

puts "current station"
puts talgo01.current_station&.name
puts "next"
puts talgo01.next_station&.name
puts "previous station"
puts talgo01.previous_station&.name

puts "Trains in Almaty: #{almaty.trains.map(&:number)}"
puts "Trains in NS: #{nur_sultan.trains.map(&:number)}"
puts "Trains in Aqtau: #{aqtau.trains.map(&:number)}"
puts "Trains in OSK: #{oskemen.trains.map(&:number)}\n"

puts "travel_forward"
talgo01.travel_forward

puts "current station"
puts talgo01.current_station&.name
puts "next"
puts talgo01.next_station&.name
puts "previous station"
puts talgo01.previous_station&.name

puts "Trains in Almaty: #{almaty.trains.map(&:number)}"
puts "Trains in NS: #{nur_sultan.trains.map(&:number)}"
puts "Trains in Aqtau: #{aqtau.trains.map(&:number)}"
puts "Trains in OSK: #{oskemen.trains.map(&:number)}\n"

puts "travel_forward"
talgo01.travel_forward

puts "current station"
puts talgo01.current_station&.name
puts "next"
puts talgo01.next_station&.name
puts "previous station"
puts talgo01.previous_station&.name

puts "Trains in Almaty: #{almaty.trains.map(&:number)}"
puts "Trains in NS: #{nur_sultan.trains.map(&:number)}"
puts "Trains in Aqtau: #{aqtau.trains.map(&:number)}"
puts "Trains in OSK: #{oskemen.trains.map(&:number)}\n"

puts "travel_forward"
talgo01.travel_forward

puts "current station"
puts talgo01.current_station&.name
puts "next"
puts talgo01.next_station&.name
puts "previous station"
puts talgo01.previous_station&.name

puts "Trains in Almaty: #{almaty.trains.map(&:number)}"
puts "Trains in NS: #{nur_sultan.trains.map(&:number)}"
puts "Trains in Aqtau: #{aqtau.trains.map(&:number)}"
puts "Trains in OSK: #{oskemen.trains.map(&:number)}\n"

puts "travel_forward"
talgo01.travel_forward

puts "current station"
puts talgo01.current_station&.name
puts "next"
puts talgo01.next_station&.name
puts "previous station"
puts talgo01.previous_station&.name

puts "Trains in Almaty: #{almaty.trains.map(&:number)}"
puts "Trains in NS: #{nur_sultan.trains.map(&:number)}"
puts "Trains in Aqtau: #{aqtau.trains.map(&:number)}"
puts "Trains in OSK: #{oskemen.trains.map(&:number)}\n"

puts "travel backward"
talgo01.travel_backward

puts "current station"
puts talgo01.current_station&.name
puts "next"
puts talgo01.next_station&.name
puts "previous station"
puts talgo01.previous_station&.name

puts "Trains in Almaty: #{almaty.trains.map(&:number)}"
puts "Trains in NS: #{nur_sultan.trains.map(&:number)}"
puts "Trains in Aqtau: #{aqtau.trains.map(&:number)}"
puts "Trains in OSK: #{oskemen.trains.map(&:number)}\n"

puts "travel backward"
talgo01.travel_backward

puts "current station"
puts talgo01.current_station&.name
puts "next"
puts talgo01.next_station&.name
puts "previous station"
puts talgo01.previous_station&.name

puts "Trains in Almaty: #{almaty.trains.map(&:number)}"
puts "Trains in NS: #{nur_sultan.trains.map(&:number)}"
puts "Trains in Aqtau: #{aqtau.trains.map(&:number)}"
puts "Trains in OSK: #{oskemen.trains.map(&:number)}\n"

puts "travel backward"
talgo01.travel_backward

puts "current station"
puts talgo01.current_station&.name
puts "next"
puts talgo01.next_station&.name
puts "previous station"
puts talgo01.previous_station&.name

puts "Trains in Almaty: #{almaty.trains.map(&:number)}"
puts "Trains in NS: #{nur_sultan.trains.map(&:number)}"
puts "Trains in Aqtau: #{aqtau.trains.map(&:number)}"
puts "Trains in OSK: #{oskemen.trains.map(&:number)}\n"

puts "travel backward"
talgo01.travel_backward

puts "current station"
puts talgo01.current_station&.name
puts "next"
puts talgo01.next_station&.name
puts "previous station"
puts talgo01.previous_station&.name

puts "Trains in Almaty: #{almaty.trains.map(&:number)}"
puts "Trains in NS: #{nur_sultan.trains.map(&:number)}"
puts "Trains in Aqtau: #{aqtau.trains.map(&:number)}"
puts "Trains in OSK: #{oskemen.trains.map(&:number)}\n"

puts "travel backward"
talgo01.travel_backward

puts "current station"
puts talgo01.current_station&.name
puts "next"
puts talgo01.next_station&.name
puts "previous station"
puts talgo01.previous_station&.name

puts "Trains in Almaty: #{almaty.trains.map(&:number)}"
puts "Trains in NS: #{nur_sultan.trains.map(&:number)}"
puts "Trains in Aqtau: #{aqtau.trains.map(&:number)}"
puts "Trains in OSK: #{oskemen.trains.map(&:number)}\n"

puts "travel backward"
talgo01.travel_backward

puts "current station"
puts talgo01.current_station&.name
puts "next"
puts talgo01.next_station&.name
puts "previous station"
puts talgo01.previous_station&.name

puts "Trains in Almaty: #{almaty.trains.map(&:number)}"
puts "Trains in NS: #{nur_sultan.trains.map(&:number)}"
puts "Trains in Aqtau: #{aqtau.trains.map(&:number)}"
puts "Trains in OSK: #{oskemen.trains.map(&:number)}\n"
