class Route

  include InstancesCounter
  attr_reader :stations, :name

  STATION_FORMAT = /^\w{4,10}$/i

  def initialize(begin_station, end_station)
    @begin_station = begin_station
    @end_station = end_station
    validate!
    @stations = []
    define_route(begin_station, end_station)
    register_instance
  end

  def add_station(station)
    if  !@stations.include? station
      @stations.insert(-2, station)
    end
  end

  def remove_station(station)
    if @stations.include?(station) && @stations.size > 1
      @stations.delete station
    end
  end

  def begin_station
    stations.first
  end

  def end_station
    stations.last
  end

  def define_route(begin_station, end_station)
    @stations << begin_station if begin_station.instance_of?(Station)
    @stations << end_station if end_station.instance_of?(Station)
    @name = "\"#{begin_station.name} - #{end_station.name}\""
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    errors = []

    errors << 'Begin station can`t be blank`' if @begin_station.name.empty?
    errors << 'End station can`t be blank`'    if @end_station.name.empty?

    raise errors.join(". ") if !errors.empty?
  end

end