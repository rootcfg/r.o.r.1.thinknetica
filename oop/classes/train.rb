class Train
  
  include Company
  include InstancesCounter
  
  attr_accessor :number, :name
  attr_reader :max_speed, :current_speed, :wagons, :type, :route, :current_station

  @@all_trains = {}

  def initialize(number, type)
    @number = number
    @type = type
    @current_speed = 0
    @wagons = []
    @@all_trains[number] = self
    register_instance
  end

  def self.find(number)
    @@all_trains[number]
  end

  def change_speed(speed)
    if speed.positive?  && speed >= 0
      (@current_speed..speed).each { |step| @current_speed = step }
    end
    @current_speed
  end

  def extra_stop
    @current_speed = 0
  end

  def make_route(route)
    if route.instance_of? Route
      @route = route
      @current_station = route.begin_station
      @current_station.arrival(self)
    end
    @route.stations
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

  protected

  def increase_wagons(wagon)
    @wagons.push(wagon) if !@wagons.include?(wagon)
  end

  def decrease_wagons(wagon)
    @wagons.delete(wagon)
  end

end