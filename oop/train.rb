class Train

  attr_accessor :number
  attr_reader :speed, :wagons, :type, :route, :current_station

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @speed = 0
    @route
    @wagons = wagons
  end

  def change_speed(speed)
    (@speed..speed).step(1).each { |step| @speed = step } if speed.positive? || speed == 0
    @speed
  end

  def extra_stop
    @speed = 0
  end

  def make_route(route)
    if route.instance_of? Route
      @route = route
      @current_station = route.begin_station
      @current_station.arrival(self)
    end
    @route.stations
  end

  def increase_wagons
    @wagons += 1 if @speed == 0
  end

  def decrease_wagons
    @wagons -= 1 if @wagons >= 1
  end

  def next_station
    current_station = @route.stations.index @current_station
    if current_station < @route.stations.size
      @route.stations[current_station += 1]
    end
  end

  def previous_station
    current_station = @route.stations.index @current_station
    if current_station < @route.stations.size
      @route.stations[current_station -= 1]
    end
  end

  def forward_movement
    @current_station.arrival(self)
    @current_station = self.next_station
  end

  def backward_movement
    @current_station.departure(self)
    @current_station = self.previous_station
  end

end