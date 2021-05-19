require_relative 'route'
require_relative 'station'
require_relative 'train'

@station1 = Station.new("Серп и Молот")
@station2 = Station.new("Нижегородская (бывш. Карачарово)	")
@station3 = Station.new("Чухлинка")
@station4 = Station.new("Кусково")
@route = Route.new(@station1,@station4)
@route.add_station @station2
@route.add_station @station3
@train = Train.new(12, :passanger, 12)
@train.make_route(@route)
@train.speed
#In IRB continue.......
