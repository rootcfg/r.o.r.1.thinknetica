# frozen_string_literal: true

class Route

  STATION_FORMAT = /^\w{4,10}$/i.freeze

  include InstancesCounter
  include Validation
  attr_reader :stations, :name

  validate :name, :presence
  validate :name, :length_min, 5
  validate :name, :length_max, 10

  def initialize(begin_station, end_station)
    @begin_station = begin_station
    @end_station = end_station
    validate!
    @stations = []
    define_route(begin_station, end_station)
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station) unless @stations.include? station
  end

  def remove_station(station)
    @stations.delete station if @stations.include?(station) && @stations.size > 1
  end

  def begin_station
    @stations.first
  end

  def end_station
    @stations.last
  end

  def define_route(begin_station, end_station)
    @stations << begin_station if begin_station.instance_of?(Station)
    @stations << end_station if end_station.instance_of?(Station)
    @name = "\"#{begin_station.name} - #{end_station.name}\""
  end

end
