require_relative 'classes/route'
require_relative 'classes/station'
require_relative 'classes/train'
require_relative 'classes/cargo_train'
require_relative 'classes/wagon'
require_relative 'classes/cargo_wagon'

@station1 = Station.new("Серп и Молот")
@station2 = Station.new("Нижегородская (бывш. Карачарово)	")
@station3 = Station.new("Чухлинка")
@station4 = Station.new("Кусково")

@route = Route.new(@station1,@station4)
@route.add_station @station2
@route.add_station @station3

@cargo_train = CargoTrain.new(11,:cargo)
@cargo_wagon12 = CargoWagon.new 12,22
@cargo_wagon13 = CargoWagon.new 13,23
@cargo_wagon14 = CargoWagon.new 14,24
@cargo_wagon15 = CargoWagon.new 15,27

@cargo_train.increase_wagons @cargo_wagon12
@cargo_train.increase_wagons @cargo_wagon13
@cargo_train.increase_wagons @cargo_wagon14
@cargo_train.increase_wagons @cargo_wagon15

@cargo_train.make_route(@route)

p @cargo_train.current_speed
  @cargo_train.change_speed 60
p @cargo_train.current_speed

#In IRB continue.......