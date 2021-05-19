class Route

  attr_reader :stations

  def initialize(begin_station, end_station)
    @stations = []
    define_route(begin_station, end_station)
  end

  def add_station(station)
    if not  @stations.include? station
      @stations.insert(-2, station)
    end
  end

  def remove_station(station)
    if @stations.include?(station) && @stations.size > 1
      @stations.delete station
    end
  end

  def begin_station
    @stations.first
  end

  def end_station
    @stations.last
  end

  def define_route(begin_station, end_station)
    @stations << begin_station << end_station if begin_station.instance_of?(Station) && end_station.instance_of?(Station)
  end

end