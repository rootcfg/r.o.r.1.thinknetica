# frozen_string_literal: true

class Train

  NUMBER_FORMAT = /^(\w|\d){3}-?(\w|\d){2}$/i.freeze

  include Company
  include InstancesCounter
  include Validation

  attr_accessor :number, :name
  attr_reader :max_speed, :current_speed, :wagons, :type, :route, :current_station

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :number, :type, String

  @@all_trains = {}

  def initialize(number, type)
    @number = number
    @type = type
    @current_speed = 0
    @wagons = []
    validate!
    @@all_trains[number] = self
    register_instance
  end

  def self.find(number)
    @@all_trains[number]
  end

  def change_speed(speed)
    (@current_speed..speed).each { |step| @current_speed = step } if speed.positive? && speed >= 0
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
    @route.stations[current_station += 1] if current_station < @route.stations.size
  end

  def previous_station
    current_station = @route.stations.index @current_station
    @route.stations[current_station -= 1] if current_station < @route.stations.size
  end

  def forward_movement
    @current_station.arrival(self)
    @current_station = next_station
  end

  def backward_movement
    @current_station.departure(self)
    @current_station = previous_station
  end

  def show_me_wagons(&block)
    @wagons.each(&block)
  end

  protected

  def increase_wagons(wagon)
    @wagons.push(wagon) unless @wagons.include?(wagon)
  end

  def decrease_wagons(wagon)
    @wagons.delete(wagon)
  end
end
